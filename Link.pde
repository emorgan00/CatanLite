enum LinkType {
	HORIZONTAL, POSITIVE, NEGATIVE;
}

class Link extends Container {

	LinkType type;
	boolean hasRoad;
	Player owner;

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
			y -= w*0.1732;
			h = w*0.3464;
		}
		
		vertices = new ArrayList<Vertex>();
	}

	void draw(float x, float y) {
		if (owner != null) {
			tint(owner.red, owner.green, owner.blue);
			super.draw(x, y);
			noTint();
		}
	}

	String toString() {
		return String.format(id+" "+type);
	}

	boolean isHovered(float mx, float my) {
		if (!active) return false;
		mx -= x;
		my -= y;
		if (type == LinkType.HORIZONTAL) {
			return (my > 0 && my < h && mx > 0 && mx < w);
		} else if (type == LinkType.POSITIVE) {
			if (my < 0 || my > h || mx < -0.2*w || mx > 1.2*w) return false; // out of bounds
			return Math.abs(1.732*mx-my) < 0.6928*w;
		} else {
			if (my < 0 || my > h || mx < -0.2*w || mx > 1.2*w) return false; // out of bounds
			return Math.abs(1.732*(w-mx)-my) < 0.6928*w;
		}
	}

}
