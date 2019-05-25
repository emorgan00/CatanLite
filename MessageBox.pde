class MessageBox extends Container {

	String text;

	MessageBox(String id, float x, float y, float w, float h, String text) {
		super(id, x, y, w, h);
		this.text = text;
	}

	void draw(float x, float y) {
		super.draw(x, y);
		// main text
		textFont(MESSAGE_FONT);
		textSize(width*0.015);
		textAlign(CENTER, CENTER);
		fill(0);
		text(text, x+this.x+w/2, y+this.y+h/2);
		// corner text
		textFont(MESSAGE_FONT_I);
		textSize(width*0.01);
		textAlign(RIGHT, BOTTOM);
		text("Click to continue...", x+this.x+w*0.97, y+this.y+h*0.97);
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
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, text);
		box.setImage("parchment");
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
	}

}