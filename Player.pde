class Player extends RadialObject {
  //Sprite
  PImage poseidon;

  //Movement
  float easing = 5;

  //Status
  boolean canMove = true;
  boolean energyCooldownOn = false;
  boolean isAttacking = false;
  boolean canAttack;
  float attackCounter = 1;
  int maxHealth = 100;
  float health = maxHealth;
  int maxEnergy = 100;
  float energy = maxEnergy;
  float energyCooldown = 3;
  float energyRegenCounter = 3;

  float bombCounter = 4;
  float harpoonCounter;


  //Status
  boolean doubleRadius = false;


  //Buffs
  float gold = 0;
  float harpoons = 0;
  float bombs = 0;
  float speedMultiplier = 1;


  //Misc
  float harpoonAngleDifference;

  //Bars
  Bar healthBar;
  Bar staminaBar;


  Player() {
    radius = 27;
    position = new PVector(); // Creates a zero vector (0, 0);
    position.x = width/2;
    position.y = 600;
    poseidon = loadImage("poseidon.png");
    healthBar = new Bar(position, -74, 70, 8, maxHealth, 172, 50, 50);
    staminaBar = new Bar(position, -60, 70, 4, maxEnergy, 251, 242, 54);
  }

  void update() {

    
    //easing = rightPressed ? 3 : 0.5;

    if (rightPressed == true && canMove) {
      if (energy > 0) {
        energyRegenCounter = 3;
        easing = 3;
        energy -= 30 * dt;
      } else {
        easing = .5;
        energyCooldownOn = true;
      }
    } else {
      if (energyRegenCounter > 0 && canMove) energyRegenCounter -= dt;
      else if (energy < 100 && canMove) energy += 20 * dt;
      easing = .5;
    }
    energy = constrain(energy, 0, 100);


    if (leftPressed && !pLeftPressed) {

      calcAngle(mouseX, mouseY);
      Whirlpool w = new Whirlpool(position.x + cos(angle) * 100, position.y + sin(angle) * 100);
      scenePlay.whirlpools.add(w);
    }

    //Spawn Harpoons
    if (harpoons > 0 && canMove) {
      harpoonCounter += dt;

      if (harpoonCounter >= 1) {
        harpoonAngleDifference = radians(360/harpoons);
        for (int i = 0; i <= harpoons; i++) {
          harpoonCounter = 0;
          Harpoon h = new Harpoon(position.x, position.y, angle + i * harpoonAngleDifference);
          scenePlay.harpoons.add(h);
        }
      }
    }


    //Spawn Bombs
    if (bombs > 0 && canMove) {
      bombCounter += dt;

      if (bombCounter >= 16/bombs) {
        bombCounter = 0;
        Bomb b = new Bomb(position.x, position.y);
        scenePlay.bombs.add(b);
      }
    }


    //Position
    float dx = mouseX - position.x;
    float dy = mouseY - position.y;

    if (canMove) {
      //Change Position
      position.x += dx * easing * speedMultiplier * dt;
      position.y += dy * easing * speedMultiplier * dt;
      //Spawn Particles
      Particle p = new Particle(position.x + random(-5, 5) + cos(angle) * 50, position.y + random(-5, 5) + sin(angle) * 50);
      scenePlay.particles.add(p);
      p.velocity.x = -150;
      p.velocity.y = -150;
      p.angle = angle + radians(random(-80, 80));
      p.size = 5;
      p.r = 220;
      p.g = 240;
      p.b = 245;
      p.rotateAngle = 0;
      p.rotateSpeed = 0;

    }

    //Max Health Check
    if (health >= maxHealth) health = maxHealth;
    

    //Set Bar Values
    healthBar.value = health;
    staminaBar.value = energy;
    
    
    
  }

  void draw() {
    fill(#B3FF71);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    calcAngle(mouseX, mouseY);
    rotate(angle + PI/2);
    image(poseidon, -poseidon.width/2, -poseidon.height/2);
    popMatrix();
    //ellipse(position.x, position.y, radius*2, radius*2);
    fill(#25D8B9);

    healthBar.draw();
    staminaBar.draw();
  }
}
