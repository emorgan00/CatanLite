GameObject VIEWPORT;

void setup() {
	size(1000, 1000);
	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
}

void draw() {
	background(0, 0, 0);
	VIEWPORT.debugDraw(0, 0);
}