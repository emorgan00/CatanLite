import java.util.*;

// globals
Container VIEWPORT, ROBBER;
Board BOARD;
PFont DEBUG_FONT, NUMBER_FONT;

void setup() {
	// setup window
	size(1500, 1000);

	// initialize globals
	loadImages();
	DEBUG_FONT = createFont("Lucida Sans", 12, true);
	NUMBER_FONT = createFont("Cambria", 64, true);

	VIEWPORT = new Container("VIEWPORT", 0, 0, width, height);
	VIEWPORT.setImage(copyImage("water"));

	BOARD = new Board("Test_Board", 300, 0, height/1.116);
	VIEWPORT.addChild(BOARD);

	// testing
	BOARD.generateTiles();
}

void draw() {
	VIEWPORT.display(0, 0);
	runEvent();
	//debug();
}

void debug() {
	stroke(255);
	textFont(DEBUG_FONT);
	textAlign(LEFT, TOP);
	for (Container child : VIEWPORT.children) child.debugDraw(0, 0);
}
