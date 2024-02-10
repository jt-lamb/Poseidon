class Particle {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float angle; // travel direction
  float rotateAngle; // sprite angle
  float rotateSpeed;
  float lifeTime;
  float size;
  float friction = 1;
  float fade = 1;

  float r, g, b;
  float alpha;

  boolean isDead = false;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(random(-150, 150), random(-150, 150));

    angle = radians(random(240, 300));
    rotateAngle = radians(random(359));
    lifeTime = random(0.5, 1.5);
    alpha = random(128, 255);
    r = g = b = random(200);
    rotateSpeed = radians(random(180));
    size = random(8, 16);
  }


  void update() {
    lifeTime -= dt;
    if (lifeTime <= 0) isDead = true;

    alpha -= 128 * dt * fade;
    
    rotateAngle += rotateSpeed * dt;
    
    velocity.x *= friction;
    velocity.y *= friction;
    
    position.x += velocity.x * cos(angle) * dt;
    position.y += velocity.y * sin(angle) * dt;

    if (alpha <= 0) isDead = true;
  }

  void draw() {
    fill(r, g, b, alpha);
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotateAngle);
    rect(0, 0, size, size);
    popMatrix();
  }
}
