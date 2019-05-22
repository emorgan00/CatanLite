import java.util.*;

// globals
Container VIEWPORT, ROBBER;
Board BOARD;
PFont DEBUG_FONT, NUMBER_FONT;
boolean DEBUG = false;

void setup() {
	// setup window
	fullScreen();

	// initialize globals
	loadImages();
	DEBUG_FONT = createFont("Lucida Sans", 12, true);
	NUMBER_FONT = createFont("Cambria", 64, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage("water");

	BOARD = new Board("BOARD", (width-height/1.03923)/2, 0, height/1.03923);
	VIEWPORT.addChild(BOARD);

	// testing
	Player p0 = new Player(255, 0, 0);
	Player p1 = new Player(0, 255, 0);
	Player p2 = new Player(0, 0, 255);
	BOARD.generateTiles();
	addEvent(new AddRoadEvent(p0));
	addEvent(new AddRoadEvent(p1));
	addEvent(new AddRoadEvent(p2));
}

void draw() {
	VIEWPORT.display(0, 0);
	runEvent();
	if (DEBUG) debug();
}

void debug() {

	// draw all objects' debug info
	stroke(255);
	textFont(DEBUG_FONT);
	textAlign(LEFT, TOP);
	for (Container child : VIEWPORT.children) child.debugDraw(0, 0);
	fill(255);

	// tell us what is being hovered
	Container hov = VIEWPORT.getLowestHovered(mouseX, mouseY);
	text("lowest hovered: "+hov, 0, 0);

	// tell us the current event
	text("current event: "+CURRENT_EVENT, 0, 15);
}

void keyPressed() {
	if (keyCode == SHIFT) DEBUG = !DEBUG;
}
