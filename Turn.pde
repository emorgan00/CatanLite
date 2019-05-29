class TurnEvent extends Event {

	Player player;
	int phase;

	TurnEvent(Player p) {
		player = p;
	}

	String toString() {
		return super.toString()+"(Player = "+player+")";
	}

	void load() {
		for (Player p : PLAYERS) p.contents.active = false;
		player.contents.active = true;

		addEvent(new RollDiceEvent());
		addEvent(new MessageBoxEvent("It is now "+player+"'s turn.", false));
		phase = 0; // we will next do robber/production
	}

	void tick() {
		if (phase == 0) { // we just created this event. wait one call until dice have been rolled.
			phase = 1;
		} else if (phase == 1) { // we have just finished rolling the dice
			int dicesum = 0;
			dicesum += ((Die)DICE.getChild("LEFT_DIE")).number;
			dicesum += ((Die)DICE.getChild("RIGHT_DIE")).number;

			if (dicesum == 7) {
				addEvent(new MoveRobberEvent());
				addEvent(new MessageBoxEvent(player+" has rolled a 7,\nand will now move the robber.", false));
			} else {
				for (int x = 0; x < BOARD.tiles.size(); x++) {
					if (BOARD.tiles.get(x).value == dicesum) {
						for (int i = 0; i < BOARD.tiles.get(x).vertices.size(); i++) {
							Player p = BOARD.tiles.get(x).vertices.get(i).owner;
							if (p != null) {
								addEvent(new AddCardEvent(p, BOARD.tiles.get(x).resource));
							}
						}
					}
				}
			}
			phase = 0;
			close();
		}
	}

}