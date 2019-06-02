void newGame() { // set up a new game
	showAll();

	// give each player a contents container and associated objects
	for (Player p : PLAYERS) {
		p.contents = new Container("PLAYER_"+p.name, 0, height*0.7, width, height*0.3);
		p.contents.active = false;
		p.contents.addChild(new CardArray("CARDS", width*0.095, height*0.12));
		p.contents.addChild(new CardArray("DEVCARDS", width*0.095, height*0.12));

		// purchasable objects
		Vertex road = new Vertex("ROAD_BUY", width*0.7, height*0.14, CARD_WIDTH*0.8);
		road.h = road.w*1.732;
		road.owner = p;
		road.setImage("road_p");
		p.contents.addChild(road);
		Vertex settlement = new Vertex("SETTLEMENT_BUY", width*0.7+CARD_WIDTH, height*0.16, CARD_WIDTH*0.8);
		settlement.owner = p;
		settlement.setImage("settlement");
		p.contents.addChild(settlement);
		Vertex city = new Vertex("CITY_BUY", width*0.7+CARD_WIDTH*2, height*0.16, CARD_WIDTH*0.8);
		city.owner = p;
		city.setImage("city");
		p.contents.addChild(city);
		
		VIEWPORT.addChild(p.contents);
	}

	// create the development card deck
	for (int i = 0; i < 14; i++) DECK.add(CardType.KNIGHT);
	for (int i = 0; i < 2; i++) {
		DECK.add(CardType.ROAD_BUILDING);
		DECK.add(CardType.YEAR_OF_PLENTY);
		DECK.add(CardType.MONOPOLY);
	}
	DECK.add(CardType.MARKET);
	DECK.add(CardType.UNIVERSITY);
	DECK.add(CardType.GREAT_HALL);
	DECK.add(CardType.CHAPEL);
	DECK.add(CardType.LIBRARY);
	Collections.shuffle(DECK);

	addEvent(new TurnLoopEvent());

	// setup the board
	for (int i = 0; i < PLAYERS.size(); i++) {
		Player p = PLAYERS.get(i);
		addEvent(new AddRoadEvent(p, true));
		addEvent(new AddSettlementEvent(p, true, true));
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

void refreshHighlights(Player player) {
	Container scratchy = CARDS.getChild("SCRATCHY_STACK");
	Container road = player.contents.getChild("ROAD_BUY");
	Container settlement = player.contents.getChild("SETTLEMENT_BUY");
	Container city = player.contents.getChild("CITY_BUY");

	int[] resources = ((CardArray)player.contents.getChild("CARDS")).resources();

	// road, settlement, city, scratchy
	if (resources[0] > 0 && resources[4] > 0) road.highlight(); 
	else road.unhighlight();
	if (resources[0] > 0 && resources[1] > 0 && resources[3] > 0 && resources[4] > 0) settlement.highlight(); 
	else settlement.unhighlight();
	if (resources[2] > 2 && resources[3] > 1) city.highlight(); 
	else city.unhighlight();
	if (resources[1] > 0 && resources[2] > 0 && resources[3] > 0 && DECK.size() > 0) scratchy.highlight(); 
	else scratchy.unhighlight();

	// resource trade-ins
	for (Resource buy : Resource.values()) {
		if (buy == Resource.DESERT) continue;
		boolean isAble = false;
		for (Resource sell : Resource.values()) {
			if (sell == Resource.DESERT) continue;
			if (resources[sell.order()] >= player.tradeRatio(buy, sell)) isAble = true;
		}
		if (isAble) CARDS.getChild(buy.getStackName()).highlight();
	}
}

void clearHighlights() {
	for (Container c : CARDS.children) c.unhighlight();
	
	for (Player player : PLAYERS) {
		player.contents.getChild("ROAD_BUY").unhighlight();
		player.contents.getChild("SETTLEMENT_BUY").unhighlight();
		player.contents.getChild("CITY_BUY").unhighlight();
	}
}
