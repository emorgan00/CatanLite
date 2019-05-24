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
	VIEWPORT.setImage("water");

	BOARD = new Board("BOARD", (width-height/1.03923)/2, 0, height/1.03923);
	VIEWPORT.addChild(BOARD);

	Card test = new ResourceCard("test", 200, 200, 400, Resource.WOOD);
	VIEWPORT.addChild(test);

	// testing
	BOARD.generateTiles();
	PLAYERS.add(new Player(255, 165, 0));
	PLAYERS.add(new Player(255, 255, 255));
	PLAYERS.add(new Player(20, 30, 220));
	for (int i = 0; i < PLAYERS.size(); i++) {
		Player p = PLAYERS.get(i);
		addEvent(new AddRoadEvent(p, true));
		addEvent(new AddSettlementEvent(p, true));
	}
	for (int i = PLAYERS.size()-1; i >= 0; i--) {
		Player p = PLAYERS.get(i);
		addEvent(new AddRoadEvent(p, true));
		addEvent(new AddSettlementEvent(p, true));
	}
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
