class Die extends Container {
  
  int number;
  
  public Die(String id, float x, float y, float w, float h) {
    super(id,x,y,w,h);
    roll();
  }
  
  void roll() {
    number = (int)(Math.random()*6)+1;
  }
}