PImage background;

PImage cloudsBack, cloudsBack2;
float cloudsBackX = 0, cloudsBackX2 = 600;
PImage cloudsFront, cloudsFront2;
float cloudsFrontX = 0, cloudsFrontX2 = 600;
PImage mountains, mountains2;
float mountainsX = 0, mountainsX2 = 600;

PImage pipeUp, pipeUp2, pipeUp3;
PImage pipeDown, pipeDown2, pipeDown3;
float pipeX = 600, pipeX2 = 900, pipeX3 = 1200;
float pipeDownY = 0, pipeDownY2 = 0, pipeDownY3 = 0;
float pipeUpY = 300, pipeUpY2 = 200, pipeUpY3 = 400; 

PImage flappyBird;
float flappyX = 50, flappyY = 50, flapSpeedUp = 1.5, flapSpeedDown = 1.5, flapThreshold = 5;
float framer = 9;
int flightState = 0;
boolean normalState = true;

void setup() {
  size(600, 450);
  loadImagesForBackground();
  loadGamePipeImages();
  randomizePipeGaps();
  loadFlappyImages();
}

void draw() {
  renderStaticImages();
  renderBackgroundImages();
  renderGamePipeImages();
  renderFlappyBird();
  collisionDetection();
}

void loadImagesForBackground() {
  background = loadImage("sky_lightened.png");
  cloudsBack = loadImage("clouds_bg.png");
  cloudsBack2 = loadImage("clouds_bg.png");
  cloudsFront = loadImage("clouds_mg_1_lightened.png");
  cloudsFront2 = loadImage("clouds_mg_1_lightened.png");
  mountains = loadImage("glacial_mountains.png");
  mountains2 = loadImage("glacial_mountains.png");
  
  background.resize(600, 450);
  cloudsBack.resize(603, 450);
  cloudsBack2.resize(603, 450);
  cloudsFront.resize(603, 450);
  cloudsFront2.resize(603, 450);
  mountains.resize(603, 450);
  mountains2.resize(603, 450);
}

void renderStaticImages() {
  image(background, 0, 0);
}

void renderBackgroundImages() {
  image(cloudsBack, cloudsBackX, -65);
  image(cloudsBack2, cloudsBackX2, -65);
  image(cloudsFront, cloudsFrontX, -135);
  image(cloudsFront2, cloudsFrontX2, -135);
  image(mountains, mountainsX, 60);
  image(mountains2, mountainsX2, 60);
  
  cloudsBackX--;
  cloudsBackX2--;
  cloudsFrontX-=1.3;
  cloudsFrontX2-=1.3;
  mountainsX-=1.8;
  mountainsX2-=1.8;
  
  if (cloudsBackX<-600) {
    cloudsBackX = 600;
  }
  if (cloudsBackX2<-600) {
    cloudsBackX2 = 600;
  }
  if (cloudsFrontX<-600) {
    cloudsFrontX = 600;
  }
  if (cloudsFrontX2<-600) {
    cloudsFrontX2 = 600;
  }
  if (mountainsX<-600) {
    mountainsX = 600;
  }
  if (mountainsX2<-600) {
    mountainsX2 = 600;
  }
}

void loadGamePipeImages() {
  pipeUp = loadImage("pipe-green.png");
  pipeUp2 = loadImage("pipe-green.png");
  pipeUp3 = loadImage("pipe-green.png");
  pipeDown = loadImage("pipe-green-down.png");
  pipeDown2 = loadImage("pipe-green-down.png");
  pipeDown3 = loadImage("pipe-green-down.png");
  
  pipeUp.resize(60, 450);
  pipeUp2.resize(60, 450);
  pipeUp3.resize(60, 450);
  pipeDown.resize(60, 450);
  pipeDown2.resize(60, 450);
  pipeDown3.resize(60, 450);
}

void renderGamePipeImages() {
  image(pipeUp, pipeX, pipeUpY);
  image(pipeUp2, pipeX2, pipeUpY2);
  image(pipeUp2, pipeX3, pipeUpY3);
  image(pipeDown, pipeX, (pipeUpY - 450) - pipeDownY);
  image(pipeDown2, pipeX2, (pipeUpY2 - 450) - pipeDownY2);
  image(pipeDown3, pipeX3, (pipeUpY3 - 450) - pipeDownY3);
  
  pipeX-=2.8;
  pipeX2-=2.8;
  pipeX3-=2.8;
  
  if (pipeX<-300) {
    pipeX = 600;
    pipeDownY = random(75, 150);
  }
  if (pipeX2<-300) {
    pipeX2 = 600;
    pipeDownY2 = random(75, 150);
  }
  if (pipeX3<-300) {
    pipeX3 = 600;
    pipeDownY3 = random(75, 150);
  }
}

void randomizePipeGaps() {
  pipeDownY = random(75, 150);
  pipeDownY2 = random(75, 150);
  pipeDownY3 = random(75, 150);
}

void loadFlappyImages() {
  flappyBird = loadImage("yellowbird-midflap.png");
  flappyBird.resize(40, 30);
}

void renderFlappyBird() {
  image(flappyBird, flappyX, flappyY);
  
  if (flappyY >= 420) {
    flapSpeedDown = 0;
  }
  if (flappyY <= 0) {
    flapSpeedUp = 0;
  }
  
  if (mousePressed) {
    normalState = false;
    framer++;
    cycleAnimations();
    flapSpeedDown = 1.5;
    flappyY -= flapSpeedUp;
    if (flapSpeedUp <= flapThreshold) {
      flapSpeedUp+= 0.4;
    }
  } else {
    if (!normalState) {
      resetFlappyBird();
    }
    flapSpeedUp = 1.5;
    flappyY += flapSpeedDown;
    if (flapSpeedDown <= flapThreshold) {
      flapSpeedDown+= 0.4;
    }
  }
}

void cycleAnimations() {
  if (framer % 10 == 0) {
    if (flightState == 0) {
      flappyBird = loadImage("yellowbird-downflap.png");
      flappyBird.resize(40, 30);
      flightState = 1;
    } else if (flightState == 1) {
      flappyBird = loadImage("yellowbird-upflap.png");
      flappyBird.resize(40, 30);
      flightState = 0;
    }
  }
}

void resetFlappyBird() {
  loadFlappyImages();
  framer = 9;
  normalState = true;
}

void collisionDetection() {
  float bottomDetection = ((pipeUpY - 450) - pipeDownY) + pipeDown.height;
  if ((pipeX >= 0 && pipeX <= 88) && ((flappyY>=pipeUpY-27) || (flappyY<=bottomDetection-4))) {
    stop();
  }
  bottomDetection = ((pipeUpY2 - 450) - pipeDownY2) + pipeDown2.height;
  if ((pipeX2 >= 0 && pipeX2 <= 88) && ((flappyY>=pipeUpY2-27) || (flappyY<=bottomDetection-4))) {
    stop();
  }
  bottomDetection = ((pipeUpY3 - 450) - pipeDownY3) + pipeDown3.height;
  if ((pipeX3 >= 0 && pipeX3 <= 88) && ((flappyY>=pipeUpY3-27) || (flappyY<=bottomDetection-4))) {
    stop();
  }
}
