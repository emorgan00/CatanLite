class Player {

	int red, green, blue;
	
	ArrayList<Vertex> settlements, cities;
	ArrayList<Link> roads;
	
	Player(int r, int g, int b) {
		red = r;
		green = g;
		blue = b;
		settlements = new ArrayList<Vertex>();
		cities = new ArrayList<Vertex>();
		roads = new ArrayList<Link>();
	}
}