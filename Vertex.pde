enum VertexType {
	LEFT, RIGHT;
}

class Vertex extends Container {

	private VertexType type;
	boolean hasSettlement, hasCity;

	ArrayList<Link> links;
	ArrayList<Tile> tiles;

	Vertex(String id, float x, float y, float w, VertexType type) {
		super(id, x, y, w, w*1.1547);
		hasSettlement = false;
		hasCity = false;
		this.type = type;

		links = new ArrayList<Link>();
		tiles = new ArrayList<Tile>();
	}

	String toString() {
		return String.format(id+" "+type);
	}

	void draw(float x, float y) {
		tint(0, 255, 0);
		super.draw(x, y);
		noTint();
	}

}