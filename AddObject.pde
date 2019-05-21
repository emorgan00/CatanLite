class AddSettlementEvent extends Event {
  
  Player player;
  Container settlement;
  boolean mousePrevious;
  
  AddSettlementEvent(Player player) {
    this.player = player;
  }
  
  void load() {
    Vertex v = BOARD.vertices.get(0);
    settlement = new Container("dummy",mouseX,mouseY,v.w,v.h);
    VIEWPORT.addChild(settlement);
    settlement.setImage("settlement");
  }
  
  void tick() {
    Container hov = BOARD.getLowestHovered(mouseX, mouseY);
    
    settlement.x = mouseX;
    settlement.y = mouseY;
    if (!mousePressed && mousePrevious) {
      if (hov instanceof Vertex && !((Vertex)hov).hasSettlement && !((Vertex)hov).hasCity) {
        VIEWPORT.children.remove(settlement);
        ((Vertex)hov).hasSettlement = true;
        hov.setImage("settlement");
        close();
      }
    }
    mousePrevious = mousePressed;
  }
}