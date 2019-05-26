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

class Label extends Container {

	String text;

	Label(String id, float x, float y, String text) {
		super(id, x, y, 0, 0);
		this.text = text;
	}

	void draw(float x, float y) {
		textFont(DEBUG_FONT);
		textSize(width*0.01);
		textAlign(CENTER, CENTER);
		fill(0);
		text(text, x+this.x, y+this.y);
	}

}

class PlayerMenuEvent extends Event {

	MessageBox box;

	void load() {
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, "Add Players:", "", CENTER, TOP);
		VIEWPORT.addChild(box);
		refreshPlayers();
	}

	void tick() {
		refreshPlayers();
	}

	void refreshPlayers() {
		// clear old vertices
		for (int j = box.children.size()-1; j > -1; j -= 1) {
			if (box.children.get(j) instanceof Vertex || box.children.get(j) instanceof Label) {
				box.children.remove(j);
			}
		}
		// add new vertices
		float x = box.w*0.125;
		for (Player p : PLAYERS) {

			Vertex v = new Vertex("COLOR_DISPLAY", x, box.h*0.2, box.w*0.15);
			v.owner = p;
			v.setImage("city");
			box.addChild(v);

			Label l = new Label("NAME_DISPLAY", x+v.w/2, box.h*0.5, p.name);
			box.addChild(l);

			x += box.w*0.2;
		}
	}

}