class Rocket extends RadialObject {
  
  
  
  PImage sprite[] = new PImage[2];
  float spriteCounter;
  int spriteIndex;

  Rocket(float x, float y, float angle) {
    position = new PVector(x, y);
    radius = 8;

    velocity = new PVector(800, 800);

    this.angle = angle;
    
    sprite[0] = loadImage("rocket1.png");
    sprite[1] = loadImage("rocket2.png");
    
    
  }

  void update() {
    
    //Animation
    spriteCounter--;
    if (spriteCounter == 0){
      spriteIndex++;
      spriteCounter = 16;
      if(spriteIndex >= sprite.length){
        spriteIndex = 0;
      }
    }
    
    //Position
    position.x += velocity.x * cos(angle) * dt;
    position.y += velocity.y * sin(angle) * dt;
    
    //Particles
    Particle p = new Particle(position.x, position.y);
    p.angle = PI + radians(random(-30, 30));
    p.rotateAngle = 0;
    p.rotateSpeed = 0;
    p.size = 6;
    if (scenePlay != null) scenePlay.particles.add(p);
    Particle fireParticle = new Particle(position.x, position.y);
    fireParticle.angle = PI + radians(random(-10, 10));
    fireParticle.r = random(240, 255);
    fireParticle.g = random(115, 240);
    fireParticle.fade = 5;
    fireParticle.rotateAngle = 0;
    fireParticle.rotateSpeed = 0;
    fireParticle.size = 6;
    if (scenePlay != null) scenePlay.particles.add(fireParticle);



    if (position.x > width + radius || position.x < - radius || position.y > height + radius || position.y < -radius) isDead = true;
  }

  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle + PI/2);
    image(sprite[spriteIndex], -sprite[spriteIndex].width/2, -sprite[spriteIndex].height/2);
    popMatrix();
  }
}
