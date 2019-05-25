class AddPlayerEvent extends Event {
	
	int timer = 0;

	void load() {
		BOARD.active = false;
		timer = 100;
	}
	
	void tick() {
		timer -= 1;
		if (timer == 0) {
			BOARD.active = true;
			close();
		}
	}

}