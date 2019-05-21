enum Resource {

	BRICK, WOOL, ORE, WHEAT, WOOD, DESERT, SCRATCHY;

	String imageName() {
		if (this == BRICK) return "hex_brick";
		else if (this == WOOL) return "hex_wool";
		else if (this == ORE) return "hex_ore";
		else if (this == WHEAT) return "hex_wheat";
		else if (this == WOOD) return "hex_wood";
		else return "hex_desert";
	}

}