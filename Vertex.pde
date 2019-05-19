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

	boolean isHovered(float mx, float my) {
		mx -= x;
		my -= y;
		if (my < 0 || my > h || mx < 0 || mx > w) return false; // out of bounds
		if (type == VertexType.RIGHT) {
			return Math.abs(2*my-h)*w/h+mx < w;
		} else {
			return Math.abs(2*my-h)*w/h+(w-mx) < w;
		}
	}

}