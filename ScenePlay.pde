// this class defines a "Play" scene
class ScenePlay {

  Player player;
  ChestGUI chestGUI;

  //Collections
  ArrayList<Whirlpool> whirlpools = new ArrayList();
  ArrayList<Rocket> rockets = new ArrayList();
  ArrayList<Enemy> enemies = new ArrayList();
  ArrayList<Particle> particles = new ArrayList();
  ArrayList<PowerUp> powerUps = new ArrayList();
  ArrayList<Bomb> bombs = new ArrayList();
  ArrayList<Harpoon> harpoons = new ArrayList();
  
  //Time
  float enemySpawnCD = 2;
  float enemySpawnRate = 1;
  float spawnRateIncreaseCD = 60;


  float gameTime = 0;
  int gTime = 0;



  ScenePlay() {
    player = new Player();
  }

  void update() {
    gameTime += dt;
    gTime = floor(gameTime);

    // SPAWN OBJECTS UNDER THIS LINE...
    if (player.gold > 0 && chestGUI == null) {
      chestGUI = new ChestGUI();
      println("spawn gui");
      player.canMove = false;
    }





    if (player.canMove) enemySpawnCD -= dt;
    if (enemySpawnCD <= 0) {
      Enemy e = new Enemy();
      enemies.add(e);
      enemySpawnCD = random(1, 3);
    }

    // UPDATE ALL OBJECTS UNDER THIS LINE...
    if (chestGUI != null) {

      chestGUI.update();

      if (chestGUI.completed == true) {
        println("gold--");
        chestGUI = null;
        player.gold--;
        player.canMove = true;
      }
    }
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.update();
      if (e.checkCollision(player)) {
        player.health -= 5;
        e.isDead = true;
      }

      if (e.isDead) enemies.remove(i);
    }

    for (int i = 0; i < powerUps.size(); i++) {
      PowerUp p = powerUps.get(i);
      p.update();

      if (p.checkCollision(player)) p.isDead = true;
      if (p.position.y > height) powerUps.remove(i);

      if (p.isDead) {
        p.effect();
        powerUps.remove(i);
      }
    }

    for (int i = 0; i < bombs.size(); i++) {
      Bomb b = bombs.get(i);
      b.update();

      for (int j = 0; j < enemies.size(); j++) {
        if (b.checkCollision(enemies.get(j))) {
          b.isDetonated = true;
          enemies.get(j).isDead = true;
        }
      }
      if (b.isDead) bombs.remove(i);
    }
    for (int i = 0; i < harpoons.size(); i++) {
      Harpoon h = harpoons.get(i);
      h.update();

      for (int j = 0; j < enemies.size(); j++) {
        if (h.checkCollision(enemies.get(j))) {
          h.isDead = true;
          enemies.get(j).isDead = true;
        }
      }
      if (h.isDead) harpoons.remove(i);
    }
    for (int i = 0; i < rockets.size(); i++) {
      Rocket r = rockets.get(i);
      r.update();

      for (int j = 0; j < enemies.size(); j++) {

        if (r.checkCollision(enemies.get(j))) {
          r.isDead = true;
          enemies.get(j).isDead = true;

          int numParticles = (int)random(25, 50);
          for (int k = 0; k < numParticles; k++) {
            Particle p = new Particle(r.position.x, r.position.y);
            p.angle = radians(random(359));
            p.velocity = new PVector(random(300, 500), random(300, 500));
            p.friction = .95;
            p.r = random(245, 255);
            p.g = random(115, 240);
            particles.add(p);
          }
          int numSmokeParticles = (int)random(25, 50);
          for (int k = 0; k < numSmokeParticles; k++) {
            Particle p = new Particle(r.position.x, r.position.y);
            p.angle = radians(random(359));
            p.velocity = new PVector(random(300, 500), random(300, 500));
            p.friction = .98;
            p.lifeTime = 4;
            p.fade = .8;
            particles.add(p);
          }
          int numShockwaveParticles = (int)random(100, 200);
          for (int k = 0; k < numShockwaveParticles; k++) {
            Particle p = new Particle(r.position.x, r.position.y);
            p.angle = radians(random(359));
            p.velocity = new PVector(1200, 1200);
            p.friction = 1;
            p.r = 255;
            p.g = 255;
            p.b = 255;
            p.lifeTime = 3;
            p.fade = 2;
            particles.add(p);
          }
        }
      }

      if (r.isDead) rockets.remove(r);
    }
    for (int i = 0; i < whirlpools.size(); i++) {
      Whirlpool w = whirlpools.get(i);
      w.update();
      if (w.isDead) whirlpools.remove(i);

      for (int j = 0; j < enemies.size(); j++) {
        Enemy e = enemies.get(j);
        if (w.checkCollision(e)) e.notDying = false;
      }
    }
    for (int i = 0; i < particles.size(); i++) {
      Particle pa = particles.get(i);
      pa.update();
      if (pa.isDead == true) particles.remove(i);
    }



    player.update();
    if (player.health <=0) switchToGameOver();
  }

  void draw() {
    // DRAW ALL OBJECTS UNDER THIS LINE...
    for (int i = 0; i < whirlpools.size(); i++) {
      Whirlpool w = whirlpools.get(i);
      w.draw();
    }

    for (int i = 0; i < powerUps.size(); i++) {
      PowerUp p = powerUps.get(i);
      p.draw();
    }
    for (int i = 0; i < bombs.size(); i++) {
      Bomb b = bombs.get(i);
      b.draw();
    }
    for (int i = 0; i < harpoons.size(); i++) {
      Harpoon h = harpoons.get(i);
      h.draw();
    }
    for (int i = 0; i < rockets.size(); i++) {
      Rocket r = rockets.get(i);
      r.draw();
    }
    for (int i = 0; i < particles.size(); i++) {
      Particle pa = particles.get(i);
      pa.draw();
    }
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.draw();
    }

    player.draw();
    if (chestGUI != null) chestGUI.draw();

    //DRAW ALL HUD ELEMENTS UNDER THIS LINE...
    textSize(20);
    text("Stamina: " + ceil(player.energy), 100, 50);
    text("Game Time: " + gTime, width/2, 50);
  }
}
