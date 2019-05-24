class RollDiceEvent extends Event {
  
  Die left, right;
  
  void load() {
    left = new Die("Left_Die",width/20,2*height/5,width/10,height/10);
    right = new Die("Right_Die",width/5,2*height/5,width/10,height/10);
    VIEWPORT.addChild(left);
    VIEWPORT.addChild(right);
  }
  
  void tick() {}
}