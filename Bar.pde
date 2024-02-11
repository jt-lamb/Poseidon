class Bar {
  PVector position;
  PVector size;
  float max;
  float value;
  float r, g, b;
  float yOffset;


  Bar(PVector pos, float yOffset, float sizeX, float sizeY, float maxValue, float red, float green, float blue) {
    position = pos;
    size = new PVector(sizeX, sizeY);
    max = maxValue;
    r = red;
    g = green;
    b = blue;
    this.yOffset = yOffset;
  }
  Bar(float x, float y, float yOffset, float sizeX, float sizeY, float maxValue, float red, float green, float blue) {
    position = new PVector(x, y);
    size = new PVector(sizeX, sizeY);
    max = maxValue;
    r = red;
    g = green;
    b = blue;
    this.yOffset = yOffset;
  }


  void update() {
  }
  void draw() {
    fill(30);
    strokeWeight(5);
    stroke(30);
    rect(position.x-size.x/2, position.y-size.y/2 + yOffset, size.x, size.y);
    noStroke();
    fill(r, g, b);
    rect(position.x-size.x/2, position.y-size.y/2 + yOffset, map(value, 0, max, 0, size.x), size.y);
  }
}
