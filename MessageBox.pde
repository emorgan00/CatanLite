class MessageBox extends Container {

	String text;
	int hAlign, vAlign;
	float tx, ty;

	MessageBox(String id, float x, float y, float w, float h, String text, int hAlign, int vAlign) {
		super(id, x, y, w, h);
		this.text = text;

		if (hAlign == CENTER) tx = w/2;
		else if (hAlign == RIGHT) tx = w*0.98;
		else if (hAlign == LEFT) tx = w*0.02;

		if (vAlign == CENTER) ty = h/2;
		else if (vAlign == BOTTOM) ty = h*0.98;
		else if (vAlign == TOP) ty = h*0.02;

		this.hAlign = hAlign;
		this.vAlign = vAlign;
		setImage("parchment");
	}

	void draw(float x, float y) {
		super.draw(x, y);
		// main text
		textFont(MESSAGE_FONT);
		textSize(width*0.015);
		textAlign(hAlign, vAlign);
		fill(0);
		text(text, x+this.x+tx, y+this.y+ty);
	}

}

class MessageBoxEvent extends Event {

	String text;
	Container box;
	boolean hideOthers, boardActive;

	MessageBoxEvent(String text, boolean hideOthers) {
		this.text = text;
		this.hideOthers = hideOthers; // hide the board and stuff when this is displayedtive = false;
	}

	void load() {
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, text, CENTER, CENTER);
		VIEWPORT.addChild(box);
		if (hideOthers) {
			boardActive = BOARD.active;
			BOARD.active = false;
		}
	}

	void tick() {
		if (box.isHovered(mouseX, mouseY) && mousePressed) {
			VIEWPORT.children.remove(box);
			if (hideOthers) {
				BOARD.active = boardActive;
			}
			close();
		}
		// corner text
		textFont(MESSAGE_FONT_I);
		textSize(width*0.01);
		textAlign(RIGHT, BOTTOM);
		text("Click to continue...", box.x+box.w*0.97, box.y+box.h*0.97);
	}

}