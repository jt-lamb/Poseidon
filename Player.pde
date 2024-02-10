class Player extends RadialObject {
  float easing = 5;


  //Status
  boolean canMove = true;
  boolean energyCooldownOn = false;
  boolean isAttacking = false;
  boolean canAttack;
  float attackCounter = 1;
  int maxEnergy = 100;
  float energy = maxEnergy;
  float energyCooldown = 3;
  float energyRegenCounter = 3;

  //Buffs
  boolean doubleRadius = false;
  int attackSpeedMultiplier = 1;

  //Items
  float gold = 0;
  float harpoons = 0;
  float bombs = 0;





  Player() {
    radius = 20;
    position = new PVector(); // Creates a zero vector (0, 0);
    position.x = width/2;
    position.y = 600;
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


    //Position
    float dx = mouseX - position.x;
    float dy = mouseY - position.y;

    position.x += dx * easing * dt;
    position.y += dy * easing * dt;
  }

  void draw() {
    fill(#B3FF71);
    noStroke();
    ellipse(position.x, position.y, radius*2, radius*2);
    fill(#25D8B9);
  }
}
