class MessageBox extends Container {

	String text, cornerText;
	int hAlign, vAlign;
	float tx, ty, offset;

	MessageBox(String id, float x, float y, float w, float h, String text, String cornerText, int hAlign, int vAlign) {
		super(id, x, y, w, h);
		this.text = text;
		this.cornerText = cornerText;

		if (hAlign == CENTER) tx = w/2;
		else if (hAlign == RIGHT) tx = w*0.95;
		else if (hAlign == LEFT) tx = w*0.05;

		if (vAlign == CENTER) ty = h/2;
		else if (vAlign == BOTTOM) ty = h*0.95;
		else if (vAlign == TOP) ty = h*0.05;

		this.hAlign = hAlign;
		this.vAlign = vAlign;
		offset = w*0.12;
		setImage("parchment");
	}

	void setImage(String name) {
		img_name = name;
		this.img = getImage(name, w+2*offset, h+2*offset);
	}

	void draw(float x, float y) {
		if (img != null) image(img, x+this.x-offset, y+this.y-offset);

		// main text
		textFont(MESSAGE_FONT);
		textSize(width*0.015);
		textAlign(hAlign, vAlign);
		fill(0);
		text(text, x+this.x+tx, y+this.y+ty);

		// corner text
		textFont(MESSAGE_FONT_I);
		textSize(width*0.01);
		textAlign(RIGHT, BOTTOM);
		fill(0);
		text(cornerText, absX()+w*0.97, absY()+h*0.97);
	}

}

class MessageBoxEvent extends Event {

	String text;
	Container box;
	boolean hideOthers, mousePrevious;

	MessageBoxEvent(String text, boolean hideOthers) {
		this.text = text;
		this.hideOthers = hideOthers; // hide the board and stuff when this is displayed.
	}

	String toString() {
		return super.toString()+"(hideOthers = "+hideOthers+")";
	}

	void load() {
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, text, "Click to continue...", CENTER, CENTER);
		VIEWPORT.addChild(box);
		if (hideOthers) {
			hideAll();
		}
	}

	void tick() {
		if (box.isHovered(mouseX, mouseY) && mousePrevious && !mousePressed) {
			VIEWPORT.children.remove(box);
			if (hideOthers) {
				showAll();
			}
			close();
		}
		mousePrevious = mousePressed;
	}

}