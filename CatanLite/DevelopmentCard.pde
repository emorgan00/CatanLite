enum CardType {

	KNIGHT, ROAD_BUILDING, YEAR_OF_PLENTY, MONOPOLY, MARKET, UNIVERSITY, GREAT_HALL, CHAPEL, LIBRARY;

	String imageName() {
		if (this == KNIGHT) return "knight_"+(int)(Math.random()*3);
		else if (this == ROAD_BUILDING) return "road_building";
		else if (this == YEAR_OF_PLENTY) return "year_of_plenty";
		else if (this == MONOPOLY) return "monopoly";
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

	}

}