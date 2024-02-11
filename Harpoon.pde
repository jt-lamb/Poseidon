class Harpoon extends RadialObject {

  PImage sprite;

  Harpoon(float x, float y, float angle) {
    position = new PVector(x, y);
    radius = 10;

    velocity = new PVector(600, 600);

    this.angle = angle;
    sprite = loadImage("harpoon.png");
  }

  void update() {
    if (scenePlay.player.canMove) {
      position.x += velocity.x * cos(angle) * dt;
      position.y += velocity.y * sin(angle) * dt;
    }
  }

  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle + PI/2);
    image(sprite, -sprite.width/2, -sprite.height/2);
    popMatrix();
  }
}
