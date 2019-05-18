class Tile extends Container {

	Resource resource;
	int value;
	boolean hasRobber;

	//ArrayList<Vertex> neighbors;

	Tile(String id, float x, float y, float w, Resource resource) {
		super(id, x, y, w, w);
		value = 0;
		hasRobber = false;
		this.resource = resource;
		setImage(hexImage(resource.imageName()));
	}

	void draw(float x, float y) {
		super.draw(x, y);
	}

	//checks whether mouse is within the bounding hexagon
	boolean isHovered(float mx, float my) {
		return false;
	}
}
