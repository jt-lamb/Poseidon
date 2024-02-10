// This program plays a mouse-based arcade game.
// Copyright 2024 John Thomas Lamb
// [Rules and controls go here]
// LEFT CLICK -
// RIGHT CLICK -
// MIDDLE MOUSE -

// create a variable to hold each scene:
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;


float dt;
float prevTime;
Player player;


void setup() {
  size(1280, 720);
  switchToTitle();
}


boolean leftPressed, pLeftPressed;
boolean rightPressed, pRightPressed;



void draw() { // This function is called every frame

  // CALCULATE DELTA TIME AND DRAW BACKGROUND UNDER THIS LINE...
  calcDeltaTime();
  background(#02A0CE);

  // UPDATE AND DRAW ANY ACTIVE SCENES:

  if (sceneTitle != null) {
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw(); // this extra if statement exists because the sceneTitle.update() might result in the scene switching...
  } else if (scenePlay != null) {
    scenePlay.update();
    if (scenePlay != null) scenePlay.draw(); // this extra if statement exists because the scenePlay.update() might result in the scene switching...
  } else if (sceneGameOver != null) {
    sceneGameOver.update();
    if (sceneGameOver != null) sceneGameOver.draw(); // this extra if statement exists because the sceneGameOver.update() might result in the scene switching...
  }
  // PREP FOR NEXT FRAME UNDER THIS LINE...
  pLeftPressed = leftPressed;
  pRightPressed = rightPressed;
}




void mousePressed() {
  if (mouseButton == LEFT) leftPressed = true;
  if (mouseButton == RIGHT) rightPressed = true;
}

void mouseReleased() {
  if (mouseButton == LEFT) leftPressed = false;
  if (mouseButton == RIGHT) rightPressed = false;
}

void calcDeltaTime() {
  float currentTime = millis();
  dt = (currentTime  - prevTime) / 1000.0;
  prevTime = currentTime;
}
void switchToTitle() {
  sceneTitle = new SceneTitle();
  scenePlay = null;
  sceneGameOver = null;
}
void switchToPlay() {
  scenePlay = new ScenePlay();
  sceneTitle = null;
  sceneGameOver = null;
}
void switchToGameOver() {
  sceneGameOver = new SceneGameOver();
  scenePlay = null;
  sceneTitle = null;
}
