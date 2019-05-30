void newGame() { // set up a new game
	showAll();

	// give each player a contents container and associated objects
	for (Player p : PLAYERS) {
		p.contents = new Container("PLAYER_"+p.name, 0, height*0.7, width, height*0.3);
		p.contents.active = false;
		p.contents.addChild(new CardArray("CARDS", width*0.05, height*0.12));
		VIEWPORT.addChild(p.contents);
	}

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

boolean boardActive, diceActive, cardsActive, roadActive, settlementActive, cityActive;

void hideAll() {
	boardActive = BOARD.active;
	BOARD.active = false;
	diceActive = DICE.active;
	DICE.active = false;
	cardsActive = CARDS.active;
	CARDS.active = false;
  roadActive = ROAD_BUY.active;
  ROAD_BUY.active = false;
  settlementActive = SETTLEMENT_BUY.active;
  SETTLEMENT_BUY.active = false;
  cityActive = CITY_BUY.active;
  CITY_BUY.active = false;
}

void showAll() {
	BOARD.active = boardActive;
	DICE.active = diceActive;
	CARDS.active = cardsActive;
  ROAD_BUY.active = roadActive;
  SETTLEMENT_BUY.active = settlementActive;
  CITY_BUY.active = cityActive;
}
