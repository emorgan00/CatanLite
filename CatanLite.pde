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
	Tile t = new Tile("Test_Tile", 400, 400, 200, Resource.DESERT);
	VIEWPORT.addChild(t);
}

void draw() {
	background(0, 0, 0);
	VIEWPORT.draw(0, 0);
	for (Container child : VIEWPORT.children) child.debugDraw(0, 0);
}
