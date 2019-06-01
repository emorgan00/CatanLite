class Player {

	int red, green, blue, points;
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
	}

	String toString() {
		return name;
	}
}