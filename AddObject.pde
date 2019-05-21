class AddSettlementEvent extends Event {
  
  Player player;
  
  AddSettlementEvent(Player player) {
    this.player = player;
  }
  
  void load() {}
  
  void tick() {}
}