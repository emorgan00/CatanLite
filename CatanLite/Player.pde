class Player {

	int red, green, blue, points, knights;
	int[][] ratios; // trade ratios, {brick, wool, ore, wheat, wood}
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
		ratios = new int[5][5];
		for (int x = 0; x < 5; x++) {
			for (int y = 0; y < 5; y++) {
				ratios[x][y] = x == y ? 999 : 4;
			}
		}
	}

	String toString() {
		return name;
	}

	int tradeRatio(Resource buy, Resource sell) {
		return ratios[buy.order()][sell.order()];
	}

	void setRatio(Resource buy, Resource sell, int r) {
		ratios[buy.order()][sell.order()] = r;
	}
}