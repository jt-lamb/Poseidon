class Enemy extends RadialObject {

  boolean notDying = true;
  float deathTimer = 2;
  int itemDrop;
  PowerUp item;

  Enemy() {
    position = new PVector(random(width), -50);

    radius = random(25, 50);

    velocity = new PVector(0, random(200, 300));
    itemDrop = floor(random(10));
  }

  void update() {
      //Position
      if (notDying && scenePlay.player.canMove) {
        position.x += velocity.x * dt;
        position.y += velocity.y * dt;
      } else if (scenePlay.player.canMove == false) {
      } else {
        //Death Timer
        deathTimer -= dt;
        radius -= dt * 5;
        radius = constrain(radius, 0, 100);

        if (deathTimer < 0) isDead = true;
      }

    if (position.y >= height + radius) isDead = true;

    if (isDead == true) {
      //decide whether or not to spawn an item, and what type
      switch (itemDrop) {
      case 0:
        item = new Chest(position.x, position.y);
      }
      
      //add item to array
      if (item != null) scenePlay.powerUps.add(item);
    }
  }

  void draw() {
    fill(#C11919);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
