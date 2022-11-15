class Pipes {
  private String _imageUp;
  private String _imageDown;
  private int _pipeCount;
  private float[] _gapDiff;
  private float[] _pipeTop;
  private float[] _pipeBottom;
  private PImage[] _pipeTops;
  private PImage[] _pipeBottoms;
  private int _screenX, _screenY;
  private boolean[] _scoreTriggers;
  
  Pipes(
    String imageUp, 
    String imageDown, 
    int pipeCount, 
    int screenX, 
    int screenY
  ) {
    _imageUp = imageUp;
    _imageDown = imageDown;
    _pipeCount = pipeCount;
    _screenX = screenX;
    _screenY = screenY;
    
    setupPipes();
  }
  
  private void setupPipes() {
    _gapDiff = new float[_pipeCount];
    _pipeTop = new float[_pipeCount];
    _pipeBottom = new float[_pipeCount];
    _pipeTops = new PImage[_pipeCount];
    _pipeBottoms = new PImage[_pipeCount];
   _scoreTriggers = new boolean[_pipeCount];
    for (int i = 0; i < _pipeCount; i++) {
      _gapDiff[i] = _screenX + (i*(_screenX/2));
      float gap = random(75, 150);
      _pipeBottom[i] = (-1 * _screenY) + random(_screenY * 0.2, _screenY * 0.7);
      _pipeTop[i] = (_screenY + _pipeBottom[i]) + gap;
      _pipeTops[i] = loadImage(_imageUp);
      _pipeBottoms[i] = loadImage(_imageDown);
      _pipeTops[i].resize(60, 450);
      _pipeBottoms[i].resize(60, 450);
      _scoreTriggers[i] = false;
    }
  }
  
  public void render(float birdHeight) {
    for (int i = 0; i < _pipeCount; i++) {
      image(_pipeTops[i], _gapDiff[i], _pipeTop[i]); 
      image(_pipeBottoms[i], _gapDiff[i], _pipeBottom[i]);
      
      _gapDiff[i] -= 2.8;
      
      float pDown = _pipeBottom[i] + _pipeBottoms[i].height;
      if ((_gapDiff[i]>=0 && _gapDiff[i]<=87) && ((birdHeight>=_pipeTop[i]-30) || (birdHeight<=pDown))) {
        stop();
      }
      if (_gapDiff[i] < 0 && !_scoreTriggers[i]) {
        GameData.getInstance().score++;
        _scoreTriggers[i] = true;
      }
      if (_gapDiff[i] < (-1 * _screenX/2)){
        if (GameData.getInstance().score % 10 == 0) {
          GameData.getInstance().difficulty -= 0.1;
        }
        float gap = random(75, 150 * GameData.getInstance().difficulty);
        _pipeBottom[i] = (-1 * _screenY) + random(_screenY * 0.2, _screenY * 0.7);
        _pipeTop[i] = (_screenY + _pipeBottom[i]) + gap;
        _gapDiff[i] = _screenX;
        _scoreTriggers[i] = false;
      } 
    }
  }
}
