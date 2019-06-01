Player SELECTED_PLAYER;

class SelectPlayerEvent extends Event {

	Button cancel;
	MessageBox box;
	boolean cancellable;
	String message;

	ArrayList<Player> players;

	SelectPlayerEvent(String message, boolean cancellable) {
		this.cancellable = cancellable;
		this.message = message;
		players = new ArrayList<Player>();
	}

	void addPlayer(Player p) {
		players.add(p);
	}

	void load() {
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, message, "", CENTER, TOP);
		VIEWPORT.addChild(box);

		float x = box.w*0.125;
		for (Player p : players) {

			Vertex v = new Vertex("COLOR_DISPLAY", x, box.h*0.2, box.w*0.15);
			v.owner = p;
			v.setImage("city");
			box.addChild(v);

			Label l = new Label("NAME_DISPLAY", x+v.w/2, box.h*0.5, p.name);
			box.addChild(l);

			Button b = new Button(p.name, l.x-box.w*0.08, box.h*0.6, box.w*0.16, box.h*0.07, "Select");
			box.addChild(b);

			x += box.w*0.2;
		}

		if (cancellable) {
			cancel = new Button("START", box.w*0.42, box.h*0.8, box.w*0.16, box.h*0.07, "Cancel");
			box.addChild(cancel);
		}
	}

	void tick() {
		Container hov = box.getLowestHovered(mouseX, mouseY);

		// button handling
		if (mousePressed && hov instanceof Button) {
			((Button)hov).pressed = true;
		} else if (hov instanceof Button && ((Button)hov).pressed) {
			SELECTED_PLAYER = null;
			if (hov != cancel) {
				for (Player p : PLAYERS) {
					if (p.name == hov.id) SELECTED_PLAYER = p;
				}
			}
			VIEWPORT.children.remove(box);
			close();
		} else {
			for (Container b : box.children) {
				if (b instanceof Button) ((Button)b).pressed = false;
			}
		}
	}

}