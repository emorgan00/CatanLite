void newGame() { // set up a new game
	BOARD.active = true;
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