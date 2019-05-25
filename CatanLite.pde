import java.util.*;

// globals
Container VIEWPORT, ROBBER, COSTS, ARMY, ROAD;
Board BOARD;
PFont DEBUG_FONT, NUMBER_FONT;
boolean DEBUG = false;
ArrayList<Player> PLAYERS = new ArrayList<Player>();

void setup() {
	// setup window
	fullScreen();

	// initialize globals
	loadImages();
	DEBUG_FONT = createFont("Lucida Sans", 12, true);
	NUMBER_FONT = createFont("Cambria", 64, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage("table");

	BOARD = new Board("BOARD", (width-height/1.3)/2, 0, height/1.3);
	VIEWPORT.addChild(BOARD);

	// testing
	BOARD.generateTiles();

	Card test = new ResourceCard("test", 200, 200, 200, Resource.WOOD);
	VIEWPORT.addChild(test);
	test = new ResourceCard("test", 420, 200, 200, Resource.WOOL);
	VIEWPORT.addChild(test);
	test = new ResourceCard("test", 640, 200, 200, Resource.ORE);
	VIEWPORT.addChild(test);
	test = new ResourceCard("test", 860, 200, 200, Resource.WHEAT);
	VIEWPORT.addChild(test);
	test = new ResourceCard("test", 1080, 200, 200, Resource.BRICK);
	VIEWPORT.addChild(test);

	addEvent(new RollDiceEvent());
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
