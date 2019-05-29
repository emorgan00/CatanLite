enum Resource {

	BRICK, WOOL, ORE, WHEAT, WOOD, DESERT;

	String imageName() {
		if (this == BRICK) return "hex_brick";
		else if (this == WOOL) return "hex_wool";
		else if (this == ORE) return "hex_ore";
		else if (this == WHEAT) return "hex_wheat";
		else if (this == WOOD) return "hex_wood";
		else return "hex_desert";
	}

	String cardImageName() {
		if (this == BRICK) return "brick_card";
		else if (this == WOOL) return "wool_card";
		else if (this == ORE) return "ore_card";
		else if (this == WHEAT) return "wheat_card";
		else if (this == WOOD) return "wood_card";
		else return "desert";
	}

	String getStackName() {
		if (this == BRICK) return "BRICK_STACK";
		else if (this == WOOL) return "WOOL_STACK";
		else if (this == ORE) return "ORE_STACK";
		else if (this == WHEAT) return "WHEAT_STACK";
		else if (this == WOOD) return "WOOD_STACK";
		else return "SCRATCHY_STACK";
	}

}

enum CardType {

	KNIGHT, ROAD_BUILDING, YEAR_OF_PLENTY, MONOPOLY, MARKET, UNIVERSITY, GREAT_HALL, CHAPEL, LIBRARY;

	String imageName() {
		return "desert"; // to do
	}

}