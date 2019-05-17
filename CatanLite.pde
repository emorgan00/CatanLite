Container VIEWPORT;
PFont DEBUG_FONT;

void setup() {
	// setup window
	size(1500, 1000, OPENGL);

	// note: the image handling should at some point all be moved to a seperate file to reduce clutter here
	PImage water = loadImage("water.jpg");
	PImage hexmask = loadImage("hexmask.jpg");

	// initialize global constants
	DEBUG_FONT = createFont("Courier New", 24, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage(water);

	// testing

	PImage test = loadImage("brick.jpg");
	test.mask(hexmask);

	Container c = new Container("HEX_CONTAINER", 50, 50, 200, 200);
	c.setImage(test);
	VIEWPORT.addChild(c);

	test = loadImage("wool.jpg");
	test.mask(hexmask);

	c = new Container("HEX_CONTAINER", 200, 133, 200, 200);
	c.setImage(test);
	VIEWPORT.addChild(c);

	test = loadImage("wood.jpg");
	test.mask(hexmask);

	c = new Container("HEX_CONTAINER", 50, 216, 200, 200);
	c.setImage(test);
	VIEWPORT.addChild(c);
}

void draw() {
	background(0, 0, 0);
	VIEWPORT.draw(0, 0);
	for (GameObject child : VIEWPORT.children) child.debugDraw(0, 0);
}