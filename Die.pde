class Die {
  
  int number;
  
  public Die() {
    roll();
  }
  
  void roll() {
    number = (int)(Math.random()*6)+1;
  }
}