class Button extends Container {

	String text;
	boolean pressed;

	Button(String id, float x, float y, float w, float h, String text) {
		super(id, x, y, w, h);
		this.text = text;
	}

	void draw(float x, float y) {
		super.draw(x, y);
		// border
		stroke(0);
		strokeWeight(2);
		if (pressed) fill(0, 0, 0, 64);
		else fill(0, 0, 0, 0);
		rect(x+this.x, y+this.y, w, h);
		// text
		textFont(DEBUG_FONT);
		textSize(width*0.01);
		textAlign(CENTER, CENTER);
		fill(0);
		text(text, x+this.x+w/2, y+this.y+h/2);
	}

}