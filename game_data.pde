public static class GameData {
  private static GameData instance;
  public int score;
  public float difficulty;
  
  private GameData() {
    score = 0;
    difficulty = 1;
  }
  
  public static GameData getInstance() {
    if (instance == null) {
      instance = new GameData();
    }
    return instance;
  }
}
