class Button {
  PVector position;
  PVector size;
  float r, g, b = 200;
  String text;
  boolean hovered;
  boolean pressed;

  Button(float x, float y, float sizeX, float sizeY, String buttonText, float red, float green, float blue) {
    position = new PVector(x, y);
    size = new PVector(sizeX, sizeY);
    text = buttonText;
    r = red;
    g = green;
    b = blue;
  }

  void update() {
    //Check if user is hovering and clicking button
    if (position.x < mouseX && mouseX < position.x + size.x) {

      if (position.y < mouseY && mouseY < position.y + size.y) {
        hovered = true;
        if (hovered && leftPressed) pressed = true;
      }else {
        hovered = false;
      }
    }else {
        hovered = false;
      }
  }

  void draw() {

    if (!hovered)fill (r, g, b);
    else fill(r+20, g+20, b+20);
    rect(position.x, position.y, size.x, size.y);
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(36);
    text(text, position.x + size.x/2, position.y+size.y/2);
  }
}
