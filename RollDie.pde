class RollDiceEvent extends Event {
  
  Die left, right;
  
  void load() {
    left = new Die("Left_Die",width/25,2*height/5,width/20,width/20);
    right = new Die("Right_Die",width/10,2*height/5,width/20,width/20);
    VIEWPORT.addChild(left);
    VIEWPORT.addChild(right);
  }
  
  void tick() {
    left.roll();
    right.roll();
    close();
  }
}
