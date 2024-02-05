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

    // UPDATE ALL OBJECTS UNDER THIS LINE...


    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.update();

      if (e.checkCollision(player)) {
        //switchToGameOver();
        e.canMove = false;
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
