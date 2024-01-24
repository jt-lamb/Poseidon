class RadialObject {

  PVector position;
  PVector velocity;
  float radius;
  boolean isDead;
  float angle;


  RadialObject() {
    
  }

  void update() { // Logical & Arithmetic updates happen in this function
  
  }

  void draw() { // Graphical updates happen in this function
  
  }

  boolean checkCollision(RadialObject other) {
    float dx = other.position.x - position.x;
    float dy = other.position.y - position.y;
    float dis = sqrt(dx * dx + dy * dy);
    if(dis <= radius + other.radius) return true;
    return false;
  }
  
  void calcAngle(RadialObject other) {
    float dx = other.position.x - position.x;
    float dy = other.position.y - position.y;
    angle = atan2(dy, dx);
    
  }
  
  void calcAngle(float x, float y) {
    float dx = x - position.x;
    float dy = y - position.y;
    angle = atan2(dy, dx);
  }
  
}
