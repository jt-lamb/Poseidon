// This program is a mouse-based arcade game.
// Copyright 2024 John Thomas Lamb
//
// Music "Aquarium" Kevin MacLeod (incompetech.com)
// Licensed under Creative Commons: By Attribution 4.0 License http://creativecommons.org/licenses/by/4.0/
//
// ==Rules==
// Defend Olympus from the invading army!
// If enough ships get through or you run out of health, the game ends.
// The game gets increasingly difficult over time, but enemies will drop items to help you get more powerful.
//
// ==Controls==
// Player moves towards cursor
// LEFT CLICK - Summon Whirlpool
// RIGHT CLICK - Sprint

import processing.sound.*;

// create a variable to hold each scene:
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;


float dt;
float prevTime;
Player player;

SoundFile explosion;
SoundFile music;
SoundFile chest;
SoundFile enemyPass;
PFont font;

void setup() {
  size(1280, 720);
  switchToTitle();
  
  
  explosion = new SoundFile(this, "explosion.wav");
  music = new SoundFile(this, "aquarium.wav");
  chest = new SoundFile(this, "chest.wav");
  enemyPass = new SoundFile(this, "enemypass.wav");
  font = createFont("moderndos.ttf", 128);
  textFont(font);
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
