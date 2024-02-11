class ChestGUI {
  //State
  boolean completed = false;
  
  //Box
  PVector position;
  PVector size;
  
  //Icons
  
  PImage harpoonFrame;
  PImage bombFrame;
  PImage speedFrame;
  
  //Buttons
  Button harpoon;
  Button bomb;
  Button moveSpeed;


  ChestGUI() {
    position = new PVector(width/2, height/2);
    size = new PVector(width/2, 5* height/6);
    harpoon = new Button(position.x -240, position.y + 150, 80, 50, "Get", 238, 195, 154);
    bomb = new Button(position.x - 40, position.y + 150, 80, 50, "Get", 238, 195, 154);
    moveSpeed = new Button(position.x+160, position.y + 150, 80, 50, "Get", 238, 195, 154);
    
    harpoonFrame = loadImage("harpoonframe.png");
    bombFrame = loadImage("bombframe.png");
    speedFrame = loadImage("bootframe.png");
  }

  void update() {
    
    //Buttons
    // Each one gives the player the relevant buff when clicked and then marks the GUI as completed.
    harpoon.update();
    if (harpoon.pressed) {
      scenePlay.player.harpoons++;
      completed = true;
    }
    bomb.update();
    if (bomb.pressed) {
      scenePlay.player.bombs++;
      completed = true;
    }
    moveSpeed.update();
    if (moveSpeed.pressed) {
      scenePlay.player.speedMultiplier += .2;
      completed = true;
    }
  }

  void draw() {
    fill(#306082);
    strokeWeight(10);
    stroke(#FFFFFF);
    rect(position.x - size.x/2, position.y - size.y/2, size.x, size.y);
    noStroke();
    
    
    fill(#ffffff);
    textSize(36);
    text("Choose a buff!", width/2, position.y - 200);
    
    //Buttons
    harpoon.draw();
    bomb.draw();
    moveSpeed.draw();
    
    //Icons
    image(harpoonFrame, harpoon.position.x - harpoonFrame.width/4, harpoon.position.y - 200);
    image(bombFrame, bomb.position.x - bombFrame.width/4, bomb.position.y - 200);
    image(speedFrame, moveSpeed.position.x - speedFrame.width/4, moveSpeed.position.y - 200);
  }
}
