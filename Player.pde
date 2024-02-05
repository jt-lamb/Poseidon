class Player extends RadialObject {

  float easing = 5;
  PVector poseidonLocation = new PVector();

  
  //Status
  boolean canMove = true;
  boolean isAttacking = false;
  float attackCounter = 1;
  int maxEnergy = 100;
  int energy = maxEnergy;

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

    easing = rightPressed ? 3 : 0.5;


    if (leftPressed && !pLeftPressed) {
      canMove = false;
      isAttacking = true;

      //calcAngle(mouseX, mouseY);
      //Rocket r = new Rocket(position.x, position.y, angle);
      //scenePlay.rockets.add(r);
    }

    if (isAttacking) {
      attackCounter -= dt;
      if (attackCounter <= 0) {
        if (radius == 20) radius = 50;
        else {
          radius = 20;
          isAttacking = false;
          canMove = true;
        }
        attackCounter = 1;
      }
    }


    //Position
    float dx = mouseX - position.x;
    float dy = mouseY - position.y;
    if (canMove) {
      position.x += dx * easing * dt;
      position.y += dy * easing * dt;
    }
    poseidonLocation.x = position.x - cos(angle) * 100;
    poseidonLocation.y = position.y - sin(angle) * 100;
  }

  void draw() {
    fill(#B3FF71);
    noStroke();
    ellipse(position.x, position.y, radius*2, radius*2);
    fill(#25D8B9);
    calcAngle(mouseX, mouseY);
    ellipse(poseidonLocation.x, poseidonLocation.y, 10, 10);
  }
}
