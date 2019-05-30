class Player {

	int red, green, blue;
	String name;
  
  int points;
	
	ArrayList<Vertex> settlements, cities;
	ArrayList<Link> roads;
	Container contents;
	
	Player(String name, int r, int g, int b) {
		red = r;
		green = g;
		blue = b;
		this.name = name;
    points = 0;
		settlements = new ArrayList<Vertex>();
		cities = new ArrayList<Vertex>();
		roads = new ArrayList<Link>();
	}

	String toString() {
		return name;
	}
}