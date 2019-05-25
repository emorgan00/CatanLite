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