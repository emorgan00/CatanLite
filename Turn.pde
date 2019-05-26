class TurnEvent extends Event {

	Player player;

	TurnEvent(Player p) {
		player = p;
	}

	void load() {
		addEvent(new RollDiceEvent());
		addEvent(new MessageBoxEvent("It is now "+player+"'s turn.", false));
	}

	void tick() {
		close();
	}

}