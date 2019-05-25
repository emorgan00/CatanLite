class Die extends Container {
	
	int number;
	
	Die(String id, float x, float y, float w) {
		super(id, x, y, w, w);
		roll();
	}
	
	void roll() {
		number = (int)(Math.random()*6)+1;
	}
}

class RollDiceEvent extends Event {
	
	Die left, right;
	
	void load() {
		left = new Die("Left_Die",width/25,2*height/5,width/20);
		right = new Die("Right_Die",width/10,2*height/5,width/20);
		VIEWPORT.addChild(left);
		VIEWPORT.addChild(right);
	}
	
	void tick() {
		left.roll();
		right.roll();
		close();
	}
}