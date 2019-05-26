class Die extends Container {
	
	int number;
	
	Die(String id, float x, float y, float w) {
		super(id, x, y, w, w);
		roll();
	}
	
	void roll() {
		number = (int)(Math.random()*6)+1;
		setImage("die_"+number);
	}
}

class RollDiceEvent extends Event {
	
	Die left, right;
	int timer;
	
	void load() {
		left = (Die)DICE.getChild("LEFT_DIE");
		right = (Die)DICE.getChild("RIGHT_DIE");
		timer = 60;
	}
	
	void tick() {
		left.roll();
		right.roll();
		if (timer < 0) close();
		timer--;
	}
}