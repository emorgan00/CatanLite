class AddPlayerEvent extends Event {

	boolean boardActive;

	void load() {
		boardActive = BOARD.active;
		BOARD.active = false;
	}
	
	void tick() {
		if (false) {
			BOARD.active = boardActive;
			close();
		}
	}

}