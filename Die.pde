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
	float timer;
	
	void load() {
		left = (Die)DICE.getChild("LEFT_DIE");
		right = (Die)DICE.getChild("RIGHT_DIE");
		timer = 1500;
	}
	
	void tick() {
		if (timer > 500) {
			left.roll();
			right.roll();
		}
		if (timer < 0) close();
		timer -= DT;
	}
}