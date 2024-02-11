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
  int maxHealth;
  float health;
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

  Player() {
    radius = 27;
    position = new PVector(); // Creates a zero vector (0, 0);
    position.x = width/2;
    position.y = 600;
    poseidon = loadImage("poseidon.png");
  }

  void update() {

    //easing = rightPressed ? 3 : 0.5;

    if (rightPressed == true) {
      if (energy > 0) {
        energyRegenCounter = 3;
        easing = 3;
        energy -= 30 * dt;
      } else {
        easing = .5;
        energyCooldownOn = true;
      }
    } else {
      if (energyRegenCounter > 0) energyRegenCounter -= dt;
      else if (energy < 100) energy += 20 * dt;
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
      position.x += dx * easing * speedMultiplier * dt;
      position.y += dy * easing * speedMultiplier * dt;
    }
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
  }
}
