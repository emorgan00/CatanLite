class Vertex extends Container {

	boolean hasSettlement, hasCity;
	Player owner;

	ArrayList<Link> links;
	ArrayList<Tile> tiles;

	Vertex(String id, float x, float y, float w) {
		super(id, x, y, w, w*1.1547);
		hasSettlement = false;
		hasCity = false;

		links = new ArrayList<Link>();
		tiles = new ArrayList<Tile>();
	}

	String toString() {
		return String.format(id);
	}

	void draw(float x, float y) {
		if (owner != null) {
			tint(owner.red, owner.green, owner.blue);
			super.draw(x, y);
			noTint();
		}
	}

}