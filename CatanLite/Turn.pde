class TurnEvent extends Event {

	Player player;
	int phase;

	boolean mousePrev;

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

		} else if (phase == 2) { // we are in the build phase

			Container hov = VIEWPORT.getLowestHovered(mouseX, mouseY);

			if (!mousePressed && mousePrev && hov != null) {
				int[] resources = ((CardArray)player.contents.getChild("CARDS")).resources();
				if (hov.id.equals("ROAD_BUY") && resources[0] > 0 && resources[4] > 0) {
					addEvent(new AddRoadEvent(player,false));
				} else if (hov.id.equals("SETTLEMENT_BUY") && resources[0] > 0 && resources[1] > 0 && resources[3] > 0 && resources[4] > 0) {
					addEvent(new AddSettlementEvent(player,false));
				} else if (hov.id.equals("CITY_BUY") && resources[2] > 2 && resources[3] > 1) {
					addEvent(new AddCityEvent(player));
				} else if (hov.id.equals("SCRATCHY_STACK") && resources[1] > 0 && resources[2] > 0 && resources[3] > 0) {
					RemoveCardsEvent rm = new RemoveCardsEvent();
					rm.addCards((CardArray)player.contents.getChild("CARDS"), card_cost);
					addEvent(new AddCardEvent(player, DECK.remove(DECK.size()-1)));
				}
			}
			
			if (keyPressed) {
				if (key == ENTER) {
					close();
				}
			}

			mousePrev = mousePressed;
		}
	}

}