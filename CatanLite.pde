Container VIEWPORT;
PFont DEBUG_FONT, NUMBER_FONT;

void setup() {
	// setup window
	size(1500, 1000, OPENGL);

	// initialize global constants
	loadImages();
	DEBUG_FONT = createFont("Lucida Sans", 12, true);
	NUMBER_FONT = createFont("Cambria", 64, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage(copyImage("water"));

	// testing
	Board b = new Board("Test_Board", 200, 0, height/1.116);
	b.generateTiles();
	VIEWPORT.addChild(b);
}

void draw() {
	VIEWPORT.display(0, 0);
	//debug();
}

void debug() {
	stroke(255);
	textFont(DEBUG_FONT);
	textAlign(LEFT, TOP);
	for (Container child : VIEWPORT.children) child.debugDraw(0, 0);
}
