class Player extends RadialObject {
  
  float easing = 3;
  
  Player() {
    radius = 20;
    position = new PVector(); // Creates a zero vector (0, 0);
    position.x = width/2;
    position.y = height/2;
  }

  void update() {
    float dx = mouseX - position.x;
    float dy = mouseY - position.y;
    
    position.x += dx * easing * dt;
    position.y += dy * easing * dt;
  }

  void draw() {
    fill(#B3FF71);
    noStroke();
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
