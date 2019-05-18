Container VIEWPORT;
PFont DEBUG_FONT;
Tile t;

void setup() {
	// setup window
	size(1500, 1000, OPENGL);

	// initialize global constants
	loadImages();
	DEBUG_FONT = createFont("Courier New", 24, true);

	VIEWPORT = new Container("VIEWPORT", 0., 0., (float)width, (float)height);
	VIEWPORT.setImage(copyImage("water"));

	// testing
	t = new Tile("Test_Tile", 200, 200, 50);
	Container c = new Container("HEX_CONTAINER", 50, 50, 200, 200);
	c.setImage(hexImage("wool"));
	VIEWPORT.addChild(c);

	c = new Container("HEX_CONTAINER", 200, 136, 200, 200);
	c.setImage(hexImage("wheat"));
	VIEWPORT.addChild(c);

	c = new Container("HEX_CONTAINER", 50, 222, 200, 200);
	c.setImage(hexImage("ore"));
	VIEWPORT.addChild(c);
}

void draw() {
	background(0, 0, 0);
	t.draw(0,0);
	VIEWPORT.draw(0, 0);
	for (Container child : VIEWPORT.children) child.debugDraw(0, 0);
}
