GameObject VIEWPORT;
PFont DEBUG_FONT;

void setup() {
	// setup window
	size(1000, 1000);

	// initialize global constants
	VIEWPORT = new Container("VIEWPORT", 10, 10, width-20, height-20);
	DEBUG_FONT = createFont("Courier New", 24, true);

	// testing
	VIEWPORT.addChild(new Container("TEST_CONTAINER", 15, 15, 200, 200));
}

void draw() {
	background(0, 0, 0);
	VIEWPORT.debugDraw(0, 0);
}