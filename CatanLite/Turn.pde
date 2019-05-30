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
				addEvent(new DelayEvent(250));
				for (Tile t : BOARD.tiles) {
					if (t.value == dicesum && t != ROBBER.parent) {
						for (Vertex v : t.vertices) {
							Player p = v.owner;
							if (p != null) {
								addEvent(new AddCardEvent(p, t.resource));
								if (v.hasCity) addEvent(new AddCardEvent(p, t.resource));
							}
						}
					}
				}
			}
			phase = 2;
		} else if (phase == 2) {
      if (keyPressed) {
        if (key == ENTER) {
          close();
        }
      }
    }
	}

}