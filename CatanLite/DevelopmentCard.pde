enum CardType {

	KNIGHT, ROAD_BUILDING, YEAR_OF_PLENTY, MONOPOLY, MARKET, UNIVERSITY, GREAT_HALL, CHAPEL, LIBRARY;

	String imageName() {
		return "cardborder"; // to do
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