enum LinkType {
	HORIZONTAL, POSITIVE, NEGATIVE;
}

class Link extends Container {

	private LinkType type;
	boolean hasRoad;

	ArrayList<Vertex> vertices;

	Link(String id, float sx, float sy, float ex, float ey) {
		super(id, Math.min(sx, ex), Math.min(sy, ey), Math.abs(sx-ex), Math.abs(sy-ey));
		hasRoad = false;
		// determine direction of link
		if (sy == ey) type = LinkType.HORIZONTAL;
		else if ((ey-sy)*(ex-sx) > 0) type = LinkType.POSITIVE;
		else type = LinkType.NEGATIVE;
		// if horizontal, resize
		if (type == LinkType.HORIZONTAL) {
			x -= w*0.1732;
			h = w*0.3464;
		}
		
		vertices = new ArrayList<Vertex>();
	}

	String toString() {
		return String.format(id+" "+type);
	}

	boolean isHovered(float mx, float my) {
		mx -= x;
		my -= y;
		if (type == LinkType.HORIZONTAL) {
			return (my > 0 && my < h && mx > 0.1*w && mx < 0.9*w);
		} else if (type == LinkType.POSITIVE) {
			mx += 0.2*w;
			if (my < 0 || my > h || mx < 0 || mx > 1.4*w) return false; // out of bounds
			return Math.abs(1.732*mx-my) < 0.6928*w && Math.abs(-.5772*mx-my+1.1548*w) < 0.9237*w;
		} else {
			mx += 0.2*w;
			if (my < 0 || my > h || mx < 0 || mx > 1.4*w) return false; // out of bounds
			return Math.abs(1.732*(w-mx)-my) < 0.6928*w && Math.abs(-.5772*(w-mx)-my+1.1548*w) < 0.9237*w;
		}
	}

}