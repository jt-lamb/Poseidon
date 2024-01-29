// this class defines a "Title" scene
class SceneTitle {
  SceneTitle() {
    
  }
  void update() {
    if (leftPressed) {
      switchToPlay();
    }
  }
  void draw() {
    background(0);
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("The Neat Game", width/2, height/2 - 30);
    textSize(12);
    text("Press ENTER to play!", width/2, height/2);
  }
  void mousePressed() {
  }
}
