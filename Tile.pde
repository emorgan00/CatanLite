class Tile extends Container {

	Resource resource;
	private int value;

	//ArrayList<Vertex> neighbors;

	Tile(String id, float x, float y, float w, Resource resource) {
		super(id, x, y, w, w);
		value = 0;
		this.resource = resource;
		setImage(hexImage(resource.imageName()));
	}

	void setValue(int value) {
		this.value = value;
		TileMarker marker = (TileMarker)this.getChild("MARKER");
		if (marker == null) {
			addChild(new TileMarker("MARKER", w*0.375, h*0.375, w*0.25, value));
		} else {
			marker.value = value;
		}
	} 

	// checks whether mouse is within the bounding hexagon
	boolean isHovered(float mx, float my) {
		mx -= x;
		my -= y+0.067*w;
		float hex_h = h*0.866;

		if (mx < 0 || mx > w || my < 0 || my > hex_h) return false; // out of bounds

		if (mx < w*0.25) { // left triangle
			if (my > hex_h/2) { // bottom triangle
				return hex_h-my > hex_h*(0.5-mx*2/w);
			} else { // top triangle
				return my > hex_h*(0.5-mx*2/w);
			}
		} else if (mx > w*0.75) { // right triangle
			if (my > hex_h/2) { // bottom triangle
				return hex_h-my > hex_h*(0.5-(w-mx)*2/w);
			} else { // top triangle
				return my > hex_h*(0.5-(w-mx)*2/w);
			}
		} else { // center rectangle
			return true;
		}
	}
}
