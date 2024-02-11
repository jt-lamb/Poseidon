class Enemy extends RadialObject {

  boolean notDying = true;
  float deathTimer = 2;
  int itemDrop;
  PowerUp item;

  //Sprite
  PImage animation[] = new PImage[3];
  float animCounter;
  int animIndex;


  Enemy() {
    position = new PVector(-50, random(height));

    radius = random(25, 50);

    velocity = new PVector(random(100, 200), 0);
    itemDrop = int(random(10));
    for (int i = 0; i < animation.length; i++) animation[i] = loadImage("ship" + (i+1) + ".png");
  }

  void update() {
    if (!isDead) {
      animCounter++;
      if (animCounter >= 5) {
        animIndex++;
        if (animIndex >= animation.length) animIndex = 0;
        animCounter = 0;
      }
    }

    //Position
    if (notDying && scenePlay.player.canMove) {
      position.x += velocity.x * dt;
      position.y += velocity.y * dt;
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
      case 7:
        item = new Bolt(position.x, position.y);
        break;
      case 8:
        item = new Wine(position.x, position.y);
        break;
      case 9:
        item = new Chest(position.x, position.y);
        break;
      }


      //add item to array
      if (item != null) scenePlay.powerUps.add(item);
    }
  }

  void draw() {
    image(animation[animIndex], position.x - animation[animIndex].width/2, position.y - animation[animIndex].height/2);
  }
}
