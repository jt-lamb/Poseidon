// This program plays a mouse-based arcade game.
// Copyright 2024 John Thomas Lamb
// [Rules and controls go here]
// LEFT CLICK -
// RIGHT CLICK -
// MIDDLE MOUSE -



float dt;
float prevTime;
Player player;

ArrayList<Rocket> rockets = new ArrayList();
ArrayList<Enemy> enemies = new ArrayList();
float enemySpawnCD = 2;

float gameTime = 0;

boolean leftPressed, pLeftPressed;
boolean rightPressed, pRightPressed;

void setup() {
  size(1280, 720);
  player = new Player();
}

void draw() { // This function is called every frame
  //CALCULATE DELTA TIME AND DRAW BACKGROUND UNDER THIS LINE...
  calcDeltaTime();
  background(220, 150, 150);

  gameTime += dt;
  int gTime = floor(gameTime);

  // SPAWN OBJECTS UNDER THIS LINE...

  enemySpawnCD -= dt;
  if (enemySpawnCD <= 0) {
    Enemy e = new Enemy();
    enemies.add(e);
    enemySpawnCD = random(0.5, 1);
  }

  // UPDATE ALL OBJECTS UNDER THIS LINE...
  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.update();

    if (e.checkCollision(player)) {
      e.isDead = true;
    }

    if (e.isDead) enemies.remove(i);
  }

  for (int i = 0; i < rockets.size(); i++) {
    Rocket r = rockets.get(i);
    r.update();

    if (r.isDead) rockets.remove(r);
  }



  player.update();


  // DRAW ALL OBJECTS UNDER THIS LINE...
  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.draw();
  }
  for (int i = 0; i < rockets.size(); i++) {
    Rocket r = rockets.get(i);
    r.draw();
  }

  player.draw();


  textSize(20);
  text ("Game Time: " + gTime, width/2, 50);

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
