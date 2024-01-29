class Particle {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float angle; // travel direction
  float rotateAngle; // sprite angle
  float rotateSpeed;
  float lifeTime;
  float size;

  float r, g, b;
  float alpha;

  boolean isDead = false;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(random(-150, 150), -300);

    angle = PI/2;
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

    alpha -= 128 * dt;
    
    rotateAngle += rotateSpeed * dt;
    
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
