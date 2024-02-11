class Bar {
  PVector position;
  PVector size;
  float max;
  float value;
  float r, g, b;


  Bar(float x, float y, float sizeX, float sizeY, float maxValue, float red, float green, float blue) {
    position = new PVector(x, y);
    size = new PVector(sizeX, sizeY);
    max = maxValue;
    r = red;
    g = green;
    b = blue;
  }

  void update() {
  }
  void draw() {
    fill(30);
    strokeWeight(5);
    stroke(30);
    rect(position.x, position.y, size.x, size.y);
    noStroke();
    fill(r, g, b);
    rect(position.x, position.y, map(value, 0, max, 0, size.x), size.y);
  }
}
