// this class defines a "Play" scene
class ScenePlay {

  Player player;

  ArrayList<Rocket> rockets = new ArrayList();
  ArrayList<Enemy> enemies = new ArrayList();
  ArrayList<Particle> particles = new ArrayList();
  float enemySpawnCD = 2;

  float gameTime = 0;
  int gTime = 0;

  ScenePlay() {
    player = new Player();
  }

  void update() {
    gameTime += dt;
    gTime = floor(gameTime);

    // SPAWN OBJECTS UNDER THIS LINE...


    enemySpawnCD -= dt;
    if (enemySpawnCD <= 0) {
      Enemy e = new Enemy();
      enemies.add(e);
      enemySpawnCD = random(0.5, 1);
    }

    Particle p = new Particle(player.position.x, player.position.y);
    particles.add(p);

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

      for (int j = 0; j < enemies.size(); j++) {

        if (r.checkCollision(enemies.get(j))) {
          r.isDead = true;
          enemies.get(j).isDead = true;
        }
      }

      if (r.isDead) rockets.remove(r);
    }
    for (int i = 0; i < particles.size(); i++) {
      Particle pa = particles.get(i);
      pa.update();
      if (pa.isDead == true) particles.remove(i);
    }



    player.update();
  }

  void draw() {
    // DRAW ALL OBJECTS UNDER THIS LINE...
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.draw();
    }
    for (int i = 0; i < rockets.size(); i++) {
      Rocket r = rockets.get(i);
      r.draw();
    }
    for (int i = 0; i < particles.size(); i++) {
      Particle pa = particles.get(i);
      pa.draw();
    }

    player.draw();


    textSize(20);
    text ("Game Time: " + gTime, width/2, 50);
  }
}
