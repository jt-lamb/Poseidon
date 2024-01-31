class Rocket extends RadialObject {

  Rocket(float x, float y, float angle) {
    position = new PVector(x, y);
    radius = 8;
    
    velocity = new PVector(800, 800);
    
    this.angle = angle;
  }

  void update() {
    
    position.x += velocity.x * cos(angle) * dt;
    position.y += velocity.y * sin(angle) * dt;
    
    Particle p = new Particle(position.x, position.y);
    p.angle = PI + radians(random(-30, 30));
    if (scenePlay != null) scenePlay.particles.add(p);
    Particle fireParticle = new Particle(position.x, position.y);
    fireParticle.angle = PI + radians(random(-10, 10));
    fireParticle.r = random(240, 255);
    fireParticle.g = random(115, 240);
    fireParticle.fade = 5;
    if (scenePlay != null) scenePlay.particles.add(fireParticle);
    
    
    
    if(position.x > width + radius || position.x < - radius || position.y > height + radius || position.y < -radius) isDead = true;
    
  }

  void draw() {
    fill(#F5EF2F);
    ellipse(position.x, position.y, radius*2, radius*2);
  }


}
