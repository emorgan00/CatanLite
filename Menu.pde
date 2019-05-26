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
	Button add, start;
	boolean queueRefresh;

	void load() {
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, "Add Players:", "", CENTER, TOP);
		VIEWPORT.addChild(box);
		refreshPlayers();

		add = new Button("ADD", box.w*0.33, box.h*0.8, box.w*0.16, box.h*0.07, "Add Player");
		box.addChild(add);
		start = new Button("START", box.w*0.51, box.h*0.8, box.w*0.16, box.h*0.07, "Begin Game");
		box.addChild(start);
	}

	void tick() {
		Container hov = box.getLowestHovered(mouseX, mouseY);

		if (queueRefresh) {
			refreshPlayers();
			queueRefresh = false;
		}

		// button handling
		if (mousePressed && hov instanceof Button) {
			((Button)hov).pressed = true;
		} else if (hov instanceof Button && ((Button)hov).pressed) {
			if (hov == add) {
				if (PLAYERS.size() < 4) addEvent(new AddPlayerEvent());
				queueRefresh = true;
			} else if (hov == start && PLAYERS.size() > 1) {
				VIEWPORT.children.remove(box);
				newGame();
				close();
			} else { // "remove" button
				for (int j = PLAYERS.size()-1; j > -1; j -= 1) {
					if (PLAYERS.get(j).name.equals(((Button)hov).id)) {
						PLAYERS.remove(j);
						refreshPlayers();
					}
				}
			}
			((Button)hov).pressed = false;
		} else {
			add.pressed = false;
			start.pressed = false;
		}
	}

	void refreshPlayers() {
		// clear old objects
		for (int j = box.children.size()-1; j > -1; j -= 1) {
			Container c = box.children.get(j);
			if (c instanceof Vertex || c instanceof Label || c instanceof Button && c != add && c != start) {
				box.children.remove(j);
			}
		}
		// add new vertices, labels, buttons
		float x = box.w*0.125;
		for (Player p : PLAYERS) {

			Vertex v = new Vertex("COLOR_DISPLAY", x, box.h*0.2, box.w*0.15);
			v.owner = p;
			v.setImage("city");
			box.addChild(v);

			Label l = new Label("NAME_DISPLAY", x+v.w/2, box.h*0.5, p.name);
			box.addChild(l);

			Button b = new Button(p.name, l.x-box.w*0.08, box.h*0.6, box.w*0.16, box.h*0.07, "Remove");
			box.addChild(b);

			x += box.w*0.2;
		}
	}

}