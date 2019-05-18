class TileMarker extends Container {

	int value;

	TileMarker(String id, float x, float y, float w, int value) {
		super(id, x, y, w, w);
		this.value = value;
		setImage(copyImage("marker"));
	}

	void draw(float x, float y) {
		super.draw(x, y);
		textFont(NUMBER_FONT);
		textSize(w*0.65);
		textAlign(CENTER, CENTER);
		fill(0);
		text(""+value, x+this.x+w*0.5, y+this.y+h*0.4);
	}

	boolean isHovered(float mx, float my) {
		return false; // this is not an interactable object.
	}

}