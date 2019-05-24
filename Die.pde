class Die extends Container {
  
  int number;
  
  public Die() {
    roll();
  }
  
  void roll() {
    number = (int)(Math.random()*6)+1;
  }
}