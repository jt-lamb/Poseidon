class PowerUp extends RadialObject {
  PImage[] sprite = new PImage[2];
  int spriteIndex;
  int spriteCounter = 16;
  PowerUp(float x, float y) {
    position = new PVector(x, y);
    radius = 10;
  }

  void update() {
  }

  void draw() {
  }



  void effect() {
    //In child classes, put what code needs to be run when the item is picked up in this function.
  }
}
