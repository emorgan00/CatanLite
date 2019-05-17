class Container extends GameObject {

	float w, h;
	PImage back;

	Container(String id, float x, float y, float w, float h) {
		super(id, x, y);
		this.w = w;
		this.h = h;
	}

	void setImage(PImage img) {
		img.resize((int)w, (int)h);
		back = img.copy();
	}

	void draw(float x, float y) {
		if (back != null)
			image(back, x+this.x, y+this.y);
		for (GameObject child : children) {
			child.draw(x+this.x, y+this.y);
		}
	}

	boolean isHovered(float mx, float my) {
		return mx > x && my > y && mx < x+w && my < y+h;
	}

	void click() {
		// Do nothing.
	}

	void debugDraw(float x, float y) {
		super.debugDraw(x, y);
		rect(x+this.x, y+this.y, w, h);
		for (GameObject child : children) {
			child.debugDraw(x+this.x, y+this.y);
		}
	}
}