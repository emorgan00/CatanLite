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
		mx -= x+0.1*h;
		my -= y+0.1536*w;
		float hex_h = h*0.6928;
		float hex_w = w*0.8; 
 
		if (mx < 0 || mx > hex_w || my < 0 || my > hex_h) return false; // out of bounds

		if (mx < hex_w*0.25) { // left triangle
			if (my > hex_h/2) { // bottom triangle
				return hex_h-my > hex_h*(0.5-mx*2/hex_w);
			} else { // top triangle
				return my > hex_h*(0.5-mx*2/hex_w);
			}
		} else if (mx > hex_w*0.75) { // right triangle
			if (my > hex_h/2) { // bottom triangle
				return hex_h-my > hex_h*(0.5-(hex_w-mx)*2/hex_w);
			} else { // top triangle
				return my > hex_h*(0.5-(hex_w-mx)*2/hex_w);
			}
		} else { // center rectangle
			return true;
		}
	}
}
