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
	Tile t = new Tile("Test_Tile", 100, 100, 800, Resource.BRICK);
	t.setValue((int)(Math.random()*11)+2);
	VIEWPORT.addChild(t);
}

void draw() {
	VIEWPORT.display(0, 0);
	debug();
}

void debug() {
	stroke(255);
	textFont(DEBUG_FONT);
	textAlign(LEFT, TOP);
	for (Container child : VIEWPORT.children) child.debugDraw(0, 0);
}
