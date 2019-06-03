enum CardType {

	KNIGHT, ROAD_BUILDING, YEAR_OF_PLENTY, MONOPOLY, MARKET, UNIVERSITY, PALACE, CHAPEL, LIBRARY;

	String imageName() {
		if (this == KNIGHT) return "knight_"+(int)(Math.random()*3);
		else if (this == ROAD_BUILDING) return "road_building";
		else if (this == YEAR_OF_PLENTY) return "year_of_plenty";
		else if (this == MONOPOLY) return "monopoly";
		else if (this == MARKET) return "market";
		else if (this == UNIVERSITY) return "university";
		else if (this == PALACE) return "palace";
		else if (this == CHAPEL) return "chapel";
		else if (this == LIBRARY) return "library";
		else return "cardborder";
	}
}

class DevelopmentCard extends Card {

	CardType type;

	DevelopmentCard(String id, float x, float y, CardType type) {
		super(id, x, y);
		this.type = type;
		setImage(type.imageName());
	}

	String toString() {
		return super.toString()+"(type = "+type+")";
	}
}

void playCard(Player player, DevelopmentCard card) {

	if (card.type == CardType.KNIGHT) {

		addEvent(new MoveRobberEvent(player));
		addEvent(new MessageBoxEvent(player+" has played a Knight,\nand will now move the robber.", false));
		player.knights++;

	} else if (card.type == CardType.MONOPOLY) {

		addEvent(new MonopolyEvent(player));
		addEvent(new MessageBoxEvent(player+", please choose a resource to\ntake from all other players.", false));

	} else if (card.type == CardType.YEAR_OF_PLENTY) {

		addEvent(new FreeCardEvent(player));
		addEvent(new FreeCardEvent(player));
		addEvent(new MessageBoxEvent(player+", please take 2 resources for free.", false));
	
	} else if (card.type == CardType.ROAD_BUILDING) {

		addEvent(new AddRoadEvent(player, false, true));
		addEvent(new AddRoadEvent(player, false, true));
		addEvent(new MessageBoxEvent(player+", please build 2 roads for free.", false));
	
	}

	RemoveCardsEvent rm = new RemoveCardsEvent();
	rm.addCard(card);
	addEvent(rm);
	for (Container c : player.contents.getChild("DEVCARDS").children) c.unhighlight();
}