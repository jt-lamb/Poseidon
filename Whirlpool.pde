class Whirlpool extends RadialObject {
  float particleCooldown = .1;
  PImage[] animation = new PImage [11];
  float animCounter;
  int animIndex;
  

  Whirlpool(float x, float y) {
    position = new PVector(x, y);
    radius = 50;
    for (int i = 0; i < animation.length; i++) animation[i] = loadImage("whirlpool" + (i+1) + ".png");
    
  }

  void update() {
    //Cycle through Animation
    if (!isDead) {
      animCounter++;
      if (animCounter >= 6) {
        animIndex++;
        if (animIndex >= animation.length) isDead = true;
        animCounter = 0;
      }
    }
    
    
    
    particleCooldown -= dt;
    if (particleCooldown < 0) {
      particleCooldown = .1;
      float pAngle = radians(random(0, 360));
      Particle p = new Particle(position.x + cos(pAngle) * 50, position.y + sin(pAngle) * 50);
      scenePlay.particles.add(p);
      p.velocity.x = 150;
      p.velocity.y = 150;
      p.angle = random(0, 360);
      p.size = 8;
      p.r = 220;
      p.g = 240;
      p.b = 245;
      p.rotateAngle = 0;
      p.rotateSpeed = 0;
    }
  }



  void draw() {
    
    ellipse(position.x, position.y, radius * 2, radius * 2);
    image(animation[animIndex], position.x - animation[animIndex].width/2, position.y - animation[animIndex].height/2);
  }
}
