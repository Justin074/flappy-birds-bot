class Bird {
  private PImage _flappyBird;
  public float birdHeight;
  private float _birdSpeed = 1.5, _birdSpeedUp = 1.5, _birdSpeedThreshold = 4;
  private int _framer = 9, _flightState = 0;
  private boolean _normalState = true;
  
  Bird(float birdHeight) {
    this.birdHeight = birdHeight;
    
    setupBird();  
  }
  
  private void setupBird() {
    _flappyBird = loadImage("yellowbird-midflap.png");
    _flappyBird.resize(40, 30);
  }
  
  public void render() {
    image(_flappyBird, 50, birdHeight);
    
    if (birdHeight<=0){_birdSpeedUp=0;}
    if (birdHeight>=420){_birdSpeed=0;}
    if (mousePressed) {
      _normalState = false;
      _framer++;
      cycleAnimation();
      _birdSpeed = 1.5;
      birdHeight-=_birdSpeedUp;
      if (_birdSpeedUp <= _birdSpeedThreshold) {
        _birdSpeedUp+=0.2;
      }
    } else {
      if (!_normalState) {
        reset();
      }
      _birdSpeedUp = 1.5;
      birdHeight+=_birdSpeed;
      if (_birdSpeed <= _birdSpeedThreshold) {
        _birdSpeed+=0.2; 
      }
    }
  }
  
  private void cycleAnimation() {
    if (_framer%10 == 0) {
      if (_flightState == 0) {
        _flappyBird = loadImage("yellowbird-downflap.png");
        _flightState = 1;
      } else if (_flightState == 1) {
        _flappyBird = loadImage("yellowbird-upflap.png");
        _flightState = 0;
      }
      _flappyBird.resize(40, 30);
    }
  }

  private void reset() {
    _flappyBird = loadImage("yellowbird-midflap.png");
    _flappyBird.resize(40, 30);
    _normalState = true;
    _framer = 9;
  }
}
