class RGBSlider extends Container {

	RGBSlider(String id, MessageBox parent, int col) {
		super(id, (col*2+1)*parent.w*0.06, parent.h*0.1, parent.w*0.06, parent.h*0.8);
		setImage("slider");
		addChild(new SliderKnob(id, this));
	}
}

class SliderKnob extends Container {

	int r, g, b;

	SliderKnob(String id, RGBSlider parent) {
		super(id, 0, 0, parent.w, parent.w/2);
		r = (parent.id.equals("R") ? 200 : 20);
		g = (parent.id.equals("G") ? 200 : 20);
		b = (parent.id.equals("B") ? 200 : 20);
	}

	void draw(float x, float y) {
		stroke(0);
		strokeWeight(1);
		fill(r, g, b);
		rect(x+this.x, y+this.y, w, h);
	}
}

class AddPlayerEvent extends Event {

	MessageBox box;
	SliderKnob selected;
	Button add, cancel;
	Label name;

	float miny, maxy;
	boolean mousePrevious;
	char lastChar;
	Player player;

	void load() {
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, "", "", CENTER, TOP);
		VIEWPORT.addChild(box);

		RGBSlider slider = new RGBSlider("R", box, 0);
		box.addChild(slider);
		slider = new RGBSlider("G", box, 1);
		box.addChild(slider);
		slider = new RGBSlider("B", box, 2);
		box.addChild(slider);

		miny = 0;
		maxy = slider.h-slider.w/2;

		add = new Button("BUTTON", box.w*0.50, box.h*0.8, box.w*0.16, box.h*0.07, "Add Player");
		box.addChild(add);
		cancel = new Button("BUTTON", box.w*0.68, box.h*0.8, box.w*0.16, box.h*0.07, "Cancel");
		box.addChild(cancel);

		player = new Player("Unnamed Player", 255, 255, 255);
		Vertex v = new Vertex("COLOR_DISPLAY", box.w*0.54, box.h*0.1, box.w*0.26);
		v.owner = player;
		v.setImage("city");
		box.addChild(v);

		name = new Label("NAME_DISPLAY", box.w*0.54+v.w/2, box.h*0.6, "Type to name player:");
		box.addChild(name);
		name = new Label("NAME_DISPLAY", box.w*0.54+v.w/2, box.h*0.7, "");
		box.addChild(name);
	}
	
	void tick() {

		Container hov = box.getLowestHovered(mouseX, mouseY);

		// check if the mouse has been interacted with
		if (mousePressed && !mousePrevious && hov instanceof SliderKnob) { // mouse down
			selected = (SliderKnob)hov;
		} else if (!mousePressed && mousePrevious) { // mouse up
			selected = null;
		}
		mousePrevious = mousePressed;

		// adjust the slider
		if (selected != null) {
			selected.y = Math.max(miny, Math.min(maxy, mouseY-box.y-selected.parent.y-selected.h/2));
			int c = 255-(int)Math.round((selected.y-miny)/(maxy-miny)*255);
			if (selected.id.equals("R")) player.red = c;
			else if (selected.id.equals("G")) player.green = c;
			else if (selected.id.equals("B")) player.blue = c;
		}

		// exit if button pressed
		if (mousePressed && hov instanceof Button) {
			((Button)hov).pressed = true;
		} else if (hov instanceof Button && (((Button)hov).pressed)) {
			VIEWPORT.children.remove(box);
			if (hov == add) PLAYERS.add(player);
			player.name = name.text;
			close();
		} else {
			add.pressed = false;
			cancel.pressed = false;
		}

		// update the player name
		if (keyPressed && lastChar != key) {
			if (Character.isLetter(key) || key == ' ') {
				name.text = name.text+key;
			} else if (key == BACKSPACE && name.text.length() > 0) {
				name.text = name.text.substring(0, name.text.length()-1);
			}
			lastChar = key;
		} else if (!keyPressed) {
			lastChar = 0;
		}
	}
}