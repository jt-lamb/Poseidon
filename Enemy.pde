class Enemy extends RadialObject {

  Enemy() {
    position = new PVector(random(width), -50);

    radius = random(25, 50);
    
    velocity = new PVector(0, random(200, 300));
  }

  void update() {
    
    position.y += 20;
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;
    
    if(position.y >= height + radius) isDead = true;
    
  }

  void draw() {
    fill(#C11919);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
