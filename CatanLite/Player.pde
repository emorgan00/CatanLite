class Player {

	int red, green, blue, points;
	int[] ratios; // trade ratios, {brick, wool, ore, wheat, wood}
	String name;
	
	ArrayList<Vertex> settlements, cities;
	ArrayList<Link> roads;
	Container contents;
	
	Player(String name, int r, int g, int b) {
		red = r;
		green = g;
		blue = b;
		points = 0;
		this.name = name;
		settlements = new ArrayList<Vertex>();
		cities = new ArrayList<Vertex>();
		roads = new ArrayList<Link>();
		ratios = new int[] {4, 4, 4, 4, 4};
	}

	String toString() {
		return name;
	}

	int tradeRatio(Resource r) {
		return ratios[r.order()];
	}
}