import java.util.*;

// globals
Container VIEWPORT, ROBBER, ARMY, ROAD, DICE, CARDS, ROAD_BUY, SETTLEMENT_BUY, CITY_BUY;
Board BOARD;
PFont DEBUG_FONT, NUMBER_FONT, MESSAGE_FONT, MESSAGE_FONT_I;
boolean DEBUG = false;
float CARD_WIDTH;
long DT, past_time;
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

	DICE = new Container("DICE", width*0.095, height*0.4, width*0.11, width/20);
	DICE.addChild(new Die("LEFT_DIE", 0, 0, width/20));
	DICE.addChild(new Die("RIGHT_DIE", width*0.06, 0, width/20));
	VIEWPORT.addChild(DICE);

	CARD_WIDTH = width*0.07;
	CARDS = new Container("CARDS", width*0.8, 0, CARD_WIDTH*1.478, height*0.8);
	CARDS.addChild(new ResourceCard("WOOD_STACK", 0, CARDS.h/2-CARD_WIDTH*3.5, Resource.WOOD));
	CARDS.addChild(new ResourceCard("BRICK_STACK", 0, CARDS.h/2-CARD_WIDTH*2.3, Resource.BRICK));
	CARDS.addChild(new ResourceCard("WOOL_STACK", 0, CARDS.h/2-CARD_WIDTH*1.1, Resource.WOOL));
	CARDS.addChild(new ResourceCard("WHEAT_STACK", 0, CARDS.h/2+CARD_WIDTH*0.1, Resource.WHEAT));
	CARDS.addChild(new ResourceCard("ORE_STACK", 0, CARDS.h/2+CARD_WIDTH*1.3, Resource.ORE));
	Card s = new Card("SCRATCHY_STACK", 0, CARDS.h/2+CARD_WIDTH*2.5);
	s.setImage("scratchy");
	CARDS.addChild(s);
	for (Container c : CARDS.children) c.flip();
	VIEWPORT.addChild(CARDS);

  ROAD_BUY = new Container("ROAD_BUY",9*width/10,8*height/10,height/20,width/20);
  VIEWPORT.addChild(ROAD_BUY);
  ROAD_BUY.setImage("road_p");
  
  SETTLEMENT_BUY = new Container("SETTLEMENT_BUY",19*width/20,8*height/10,height/20,width/20);
  VIEWPORT.addChild(SETTLEMENT_BUY);
  SETTLEMENT_BUY.setImage("settlement");
  
  CITY_BUY = new Container("CITY_BUY",37*width/40,9*height/10,height/20,width/20);
  VIEWPORT.addChild(CITY_BUY);
  CITY_BUY.setImage("city");

	// testing
	BOARD.generateTiles();
	hideAll();
	addEvent(new PlayerMenuEvent());
}

void draw() {
	runEvent();
	VIEWPORT.display(0, 0);
	if (DEBUG) debug();

	// updating DT
	DT = System.currentTimeMillis()-past_time;
	past_time = System.currentTimeMillis();
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
	text("Lowest Hovered: "+hov, 0, 0);

	// tell us the current event
	text("Current Event: "+EVENT_STACK.peekFirst(), 0, 15);

	// tell us the frameRate
	text("FrameRate: "+frameRate, 0, 30);
}

void keyPressed() {
	if (keyCode == TAB) DEBUG = !DEBUG;

	Event event = EVENT_STACK.peekFirst();
	if (event != null) {
		event.keyPressed();
	}		
}
