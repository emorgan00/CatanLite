Container VIEWPORT;
PFont DEBUG_FONT;

void setup() {
	// setup window
	size(1500, 1000, OPENGL);

	// initialize global constants
	DEBUG_FONT = createFont("Courier New", 24, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage("water.jpg");

	// testing
	VIEWPORT.addChild(new Container("TEST_CONTAINER", 15, 15, 200, 200));
}

void draw() {
	background(0, 0, 0);
	VIEWPORT.draw(0, 0);
	for (GameObject child : VIEWPORT.children) child.debugDraw(0, 0);
}