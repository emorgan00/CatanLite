void newGame() { // set up a new game
	showAll();
  
  addEvent(new TurnLoopEvent());
  
	// setup the board
	for (int i = 0; i < PLAYERS.size(); i++) {
		Player p = PLAYERS.get(i);
		addEvent(new AddRoadEvent(p, true));
		addEvent(new AddSettlementEvent(p, true));
	}
	for (int i = PLAYERS.size()-1; i >= 0; i--) {
		Player p = PLAYERS.get(i);
		addEvent(new AddRoadEvent(p, true));
		addEvent(new AddSettlementEvent(p, true));
	}

	addEvent(new MessageBoxEvent("Board setup:\n\nEach player gets to place one settlement and one road.\nThe road must be placed next to the settlement.", false));
}

void loadGame() {

}

boolean boardActive, diceActive, cardsActive;

void hideAll() {
	boardActive = BOARD.active;
	BOARD.active = false;
	diceActive = DICE.active;
	DICE.active = false;
	cardsActive = CARDS.active;
	CARDS.active = false;
}

void showAll() {
	BOARD.active = boardActive;
	DICE.active = diceActive;
	CARDS.active = cardsActive;
}

class TurnLoopEvent extends Event {
  void load() {}
  
  void tick() {
    for (int x = PLAYERS.size()-1; x >= 0; x--) {
      addEvent(new TurnEvent(PLAYERS.get(x)));
    }
  }
}