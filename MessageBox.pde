class MessageBoxEvent extends Event {

	String text;
	Container box;
	boolean hideOthers, boardActive;

	MessageBoxEvent(String text, boolean hideOthers) {
		this.text = text;
		this.hideOthers = hideOthers; // hide the board and stuff when this is displayedtive = false;
	}

	void load() {
		box = new Container("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4);
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
		// border
		stroke(0);
		strokeWeight(8);
		fill(0, 0, 0, 0);
		rect(box.x, box.y, box.w, box.h);
		// main text
		textFont(MESSAGE_FONT);
		textSize(width*0.015);
		textAlign(CENTER, CENTER);
		fill(0);
		text(text, width/2, height/2);
		// corner text
		textFont(MESSAGE_FONT_I);
		textSize(width*0.01);
		textAlign(RIGHT, BOTTOM);
		text("Click to continue...", width*0.68, height*0.68);
	}

}