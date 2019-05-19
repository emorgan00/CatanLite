enum LinkType {
	HORIZONTAL, POSITIVE, NEGATIVE;
}

class Link extends Container {

	private LinkType type;
	boolean hasRoad;
	//ArrayList<Vertex> vertices;

	Link(String id, float sx, float sy, float ex, float ey) {
		super(id, Math.min(sx, ex), Math.min(sy, ey), Math.abs(sx-ex), Math.abs(sy-ey));
		hasRoad = false;
		// determine direction of link
		if (sy == ey) type = LinkType.HORIZONTAL;
		else if ((ey-sy)*(ex-ey) > 0) type = LinkType.POSITIVE;
		else type = LinkType.NEGATIVE;
	}

}