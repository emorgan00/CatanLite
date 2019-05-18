enum Resource {

	BRICK, WOOL, ORE, WHEAT, WOOD, DESERT, SCRATCHY;

	String imageName() {
		if (this == BRICK) return "brick";
		else if (this == WOOL) return "wool";
		else if (this == ORE) return "ore";
		else if (this == WHEAT) return "wheat";
		else if (this == WOOD) return "wood";
		else return "desert";
	}

}