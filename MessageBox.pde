class MessageBoxEvent extends Event {

	String text;
	Container box;

	MessageBoxEvent(String text) {
		this.text = text;
	}

	void load() {
		box = new Container("MESSAGE_BOX", width*0.1, width*0.1, width*0.8, height-width*0.2);
		VIEWPORT.addChild(box);
	}

	void tick() {
		if (box.isHovered(mouseX, mouseY) && mousePressed) {
			VIEWPORT.children.remove(box);
			close();
		}
	}

}