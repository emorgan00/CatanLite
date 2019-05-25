import java.util.*;

// globals
Container VIEWPORT, ROBBER, COSTS, ARMY, ROAD;
Board BOARD;
PFont DEBUG_FONT, NUMBER_FONT, MESSAGE_FONT, MESSAGE_FONT_I;
boolean DEBUG = false;
ArrayList<Player> PLAYERS = new ArrayList<Player>();

void setup() {
	// setup window
	fullScreen();

	// initialize globals
	loadImages();
	DEBUG_FONT = createFont("Lucida Sans", 12, true);
	NUMBER_FONT = createFont("Cambria", 64, true);
	MESSAGE_FONT = createFont("Georgia", 64, true);
	MESSAGE_FONT_I = createFont("Georgia Italic", 64, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage("table");

	BOARD = new Board("BOARD", (width-height/1.3)/2, height/100, height/1.3);
	VIEWPORT.addChild(BOARD);

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
	// example:
	addEvent(new MessageBoxEvent("Notice:\n\nPLAYER 1 has built the longest road\nand now holds the longest road card.", false));
}

void draw() {
	VIEWPORT.display(0, 0);
	runEvent();
	if (DEBUG) debug();
}

void debug() {

	// draw all objects' debug info
	stroke(255);
	strokeWeight(1);
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
