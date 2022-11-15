class BackgroundImage {
  private float _startingCoordinate;
  private float _duplicationCoordinate;
  private PImage _backgroundImage;
  private float _backgroundSpeed;
  private String _imageUrl;
  private int _screenX, _screenY;
  private int _heightOffset;
  
  BackgroundImage(
    int startingCoordinate, 
    int duplicationCoordinate, 
    float backgroundSpeed, 
    String imageUrl, 
    int screenX, 
    int screenY, 
    int heightOffset
  ) {
    _startingCoordinate = startingCoordinate;
    _duplicationCoordinate = duplicationCoordinate;
    _backgroundSpeed = backgroundSpeed;
    _imageUrl = imageUrl;
    _screenX = screenX;
    _screenY = screenY;
    _heightOffset = heightOffset;
    
    setupBackground();
  }
  
  private void setupBackground() {
    _backgroundImage = loadImage(_imageUrl);
    _backgroundImage.resize(_screenX + 3, _screenY);
  }
  
  public void render(Boolean animated) {
    image(_backgroundImage, _startingCoordinate, _heightOffset);
    
    if (animated) {
      image(_backgroundImage, _duplicationCoordinate, _heightOffset);
      
      _startingCoordinate -= _backgroundSpeed;
      _duplicationCoordinate -= _backgroundSpeed;
      
      if (_startingCoordinate < (-1 * _screenX)) {
        _startingCoordinate = _screenX;
      } 
    
      if (_duplicationCoordinate < (-1 * _screenX)) {
        _duplicationCoordinate = _screenX;
      }
    }
  }
}
