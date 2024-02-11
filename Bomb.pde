class Bomb extends RadialObject {
  boolean isDetonated;
  PImage sprite[] = new PImage[6];
  int spriteIndex;
  float spriteCounter;


  Bomb(float x, float y) {
    position = new PVector(x, y);
    radius = 30;
    for (int i = 0; i < sprite.length; i++) {
      sprite[i] = loadImage("bomb" + (i+1) + ".png");
    }
  }
  void update() {
    if (isDetonated) {
      spriteCounter++;
      if (spriteCounter == 4) {
        spriteCounter = 0;
        spriteIndex++;
        if (spriteIndex >= sprite.length) isDead = true;
      }
    }
  }

  void draw() {
    fill(#ffffff);
    image(sprite[spriteIndex], position.x - sprite[spriteIndex].width/2, position.y- sprite[spriteIndex].height/2);
  }
}
