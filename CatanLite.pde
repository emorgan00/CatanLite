Container VIEWPORT;
PFont DEBUG_FONT;

void setup() {
	// setup window
	size(1500, 1000, OPENGL);

	// initialize global constants
	loadImages();
	DEBUG_FONT = createFont("Courier New", 24, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage(copyImage("water"));

	// testing
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
	VIEWPORT.draw(0, 0);
	for (GameObject child : VIEWPORT.children) child.debugDraw(0, 0);
}