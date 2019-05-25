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
		fill(r, g, b);
		rect(x+this.x, y+this.y, w, h);
	}

}

class AddPlayerEvent extends Event {

	MessageBox box;
	SliderKnob selected;
	float miny, maxy;
	boolean mousePrevious, enterDown;
	Player player;

	void load() {
		box = new MessageBox("MESSAGE_BOX", width*0.3, height*0.3, width*0.4, height*0.4, "", "Press Enter to continue...", CENTER, TOP);
		VIEWPORT.addChild(box);

		RGBSlider slider = new RGBSlider("R", box, 0);
		box.addChild(slider);
		slider = new RGBSlider("G", box, 1);
		box.addChild(slider);
		slider = new RGBSlider("B", box, 2);
		box.addChild(slider);

		miny = 0;
		maxy = slider.h-slider.w/2;

		player = new Player(255, 255, 255);
		Vertex v = new Vertex("COLOR_DISPLAY", box.w*0.54, box.y*0.1, box.w*0.26);
		v.owner = player;
		v.setImage("city");
		box.addChild(v);
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

		// exit if enter pressed
		if (keyPressed && key == ENTER) {
			enterDown = true;
		} else if (enterDown) {
			VIEWPORT.children.remove(box);
			PLAYERS.add(player);
			close();
			// these two things are for testing purposed:
			addEvent(new AddRoadEvent(player, true));
			addEvent(new AddSettlementEvent(player, true));
		}
	}
}