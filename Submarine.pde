class Submarine extends Enemy {
  float modeChangeCD = 4;

  //Sprites
  PImage[] submerging = new PImage[3];
  int submergingIndex;
  float submergingCounter;
  PImage[] submerged = new PImage[3];
  int submergedIndex;
  float submergedCounter;

  //States
  boolean isSubmerging;
  boolean isSubmerged;
  boolean isEmerging;

  Submarine() {
    super();
    for (int i = 0; i < animation.length; i++) animation[i] = loadImage("sub" + (i+1) + ".png");
    for (int i = 0; i < submerging.length; i++) submerging[i] = loadImage("sub-submerge" + (i+1) + ".png");
    for (int i = 0; i < submerged.length; i++) submerged[i] = loadImage("sub-submerged" + (i+1) + ".png");
    velocity.x = random(30, 80);
  }

  void update() {
    if (!isDead && !isSubmerged) {
      animCounter++;
      if (animCounter >= 5) {
        animIndex++;
        if (animIndex >= animation.length) animIndex = 0;
        animCounter = 0;
      }
    } else if (!isDead && isSubmerged) {
      submergedCounter++;
      if (submergedCounter >= 5) {
        submergedIndex++;
        if (submergedIndex >= submerged.length) submergedIndex = 0;
        submergedCounter = 0;
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

    if (position.x >= width + radius) {
      isDead = true;
      scenePlay.olympusHealth--;
      enemyPass.play();
    }

    //Change Mode
    modeChangeCD -= dt;
    if (modeChangeCD <= 0) {
      if (isSubmerged) {
        isEmerging = true;
        isSubmerged = false;
      }
      else isSubmerging = true;
      modeChangeCD = 4;
      println("mode change");
    }

    //Submerge Animation
    if (isSubmerging == true) {
      submergingCounter++;
      if (submergingCounter >= 5) {
        submergingCounter = 0;
        submergingIndex++;
        if (submergingIndex >= submerging.length) {
          isSubmerged = true;
          isSubmerging = false;
          submergingIndex--;
          radius = radius/2;
        }
      }
    }
    //Emerge Animation
    if (isEmerging == true) {
      submergingCounter++;
      if (submergingCounter >= 5) {
        submergingCounter = 0;
        submergingIndex--;
        if (submergingIndex <= 0) {
          submergingIndex++;
          isSubmerged = false;
          isEmerging = false;
          calcAngle(scenePlay.player);
          Rocket r = new Rocket(position.x, position.y, angle);
          scenePlay.rockets.add(r);
          angle = 0;
          radius = radius*2;
        }
      }
    }




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
    if (isSubmerged) image(submerged[submergedIndex], position.x - submerged[submergedIndex].width/2, position.y - submerged[submergedIndex].height/2);
    else if (isSubmerging || isEmerging) image(submerging[submergingIndex], position.x - submerging[submergingIndex].width/2, position.y - submerging[submergingIndex].height/2);
    else image(animation[animIndex], position.x - animation[animIndex].width/2, position.y - animation[animIndex].height/2);
  }
}
