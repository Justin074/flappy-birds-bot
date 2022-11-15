static final int screenX = 600, screenY = 450;

BackgroundImage back;
BackgroundImage mid;
BackgroundImage front;
BackgroundImage sky;

Pipes pipes;

Bird flappyBird;

void setup() {
  // Setup screen sizeing
  size(600, 450);
  
  // Background image initialisation
  back = new BackgroundImage(0, screenX, 1, "clouds_bg.png", screenX, screenY, 0);
  mid = new BackgroundImage(0, screenX, 1.3, "clouds_mg_1_lightened.png", screenX, screenY, -125);
  front = new BackgroundImage(0, screenX, 2, "glacial_mountains.png", screenX, screenY, 80);
  sky = new BackgroundImage(0, screenX, 0, "sky_lightened.png", screenX, screenY, 0);
  
  // Pipe initialisation
  pipes = new Pipes("pipe-green.png", "pipe-green-down.png", 3, screenX, screenY);
  
  // Bird initialisation
  flappyBird = new Bird(50);
}

void draw() {
  // Background image rendering
  sky.render(false);
  back.render(true);
  mid.render(true);
  front.render(true);
  
  // Pipes image rendering and bird collision detection
  pipes.render(flappyBird.birdHeight);
  
  // Draw current game score
  textSize(75);
  text(GameData.getInstance().score, 5, 58);
  
  // Bird image rendering and animations
  flappyBird.render();
}
