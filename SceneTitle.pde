// this class defines a "Title" scene
Button playButton;
Button exitButton;

class SceneTitle {
  SceneTitle() {
    playButton = new Button(width/2 - 100, height/3 + 100, 200, 100, "Play", 200, 200, 200);
    exitButton = new Button(width/2 - 100, height/3 + 300, 200, 100, "Quit", 200, 200, 200);
  }
  void update() {
    playButton.update();
    if (playButton.pressed) switchToPlay();
    exitButton.update();
    if (exitButton.pressed) exit();
  }
  void draw() {
    background(0);
    playButton.draw();
    exitButton.draw();

    fill(255);
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Tiny Poseidon", width/2, height/3);
  }
  void mousePressed() {
  }
}
