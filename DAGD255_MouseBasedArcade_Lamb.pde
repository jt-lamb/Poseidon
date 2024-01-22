//Copyright 2024 John Thomas Lamb

float dt;
float prevTime;
Player player;

ArrayList<Enemy> enemies = new ArrayList();
float enemySpawnCD = 2;


void setup() {
  size(1280, 720);
  player = new Player();
}

void draw() { // This function is called every frame
  //CALCULATE DELTA TIME AND DRAW BACKGROUND UNDER THIS LINE...
  calcDeltaTime();
  background(220, 150, 150);
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
    
    if(e.isDead) enemies.remove(i);
  }



  player.update();


  // DRAW ALL OBJECTS UNDER THIS LINE...
  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.draw();
  }



  player.draw();


  // PREP FOR NEXT FRAME UNDER THIS LINE...
}


void calcDeltaTime() {
  float currentTime = millis();
  dt = (currentTime  - prevTime) / 1000.0;
  prevTime = currentTime;
}
