class Player {

	int red, green, blue;
	String name;
	
	ArrayList<Vertex> settlements, cities;
	ArrayList<Link> roads;
  ArrayList<Card> cards;
	
	Player(String name, int r, int g, int b) {
		red = r;
		green = g;
		blue = b;
		this.name = name;
		settlements = new ArrayList<Vertex>();
		cities = new ArrayList<Vertex>();
		roads = new ArrayList<Link>();
    cards = new ArrayList<Card>();
	}

	String toString() {
		return name;
	}

  void addCard(Card card) {
    cards.add(card);
  }
}