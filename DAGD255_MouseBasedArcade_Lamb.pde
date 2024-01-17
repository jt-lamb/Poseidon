//Copyright 2024 John Thomas Lamb

float dt;
float prevTime;
Player player;

void setup(){
  size(1280,720);
  player = new Player();
}

void draw(){ // This function is called every frame
  //CALCULATE DELTA TIME AND DRAW BACKGROUND UNDER THIS LINE...
  calcDeltaTime();
  background(220,150,150);
  // SPAWN OBJECTS UNDER THIS LINE...
  
  // UPDATE ALL OBJECTS UNDER THIS LINE...
  player.update();
  // DRAW ALL OBJECTS UNDER THIS LINE...
  player.draw();
  
  
  // PREP FOR NEXT FRAME UNDER THIS LINE...
  
}


void calcDeltaTime() {
  float currentTime = millis();
  dt = (currentTime  - prevTime) / 1000.0;
  prevTime = currentTime;
}
