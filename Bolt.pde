class Bolt extends PowerUp {
  
  
  
  Bolt(float x, float y){
    super(x, y);
    sprite[0] = loadImage("bolt1.png");
    sprite[1] = loadImage("bolt2.png");
    radius = 20;
  }
  
  void update(){
    spriteCounter--;
    if (spriteCounter == 0){
      spriteIndex++;
      spriteCounter = 16;
      if(spriteIndex >= sprite.length){
        spriteIndex = 0;
      }
    }
    
  }
  
  void draw(){
    image(sprite[spriteIndex], position.x - sprite[spriteIndex].width/2, position.y - sprite[spriteIndex].height/2);
    
  }
  
  void effect(){
    scenePlay.player.energy = 100;
  }
  
}
