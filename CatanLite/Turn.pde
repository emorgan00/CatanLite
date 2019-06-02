class TurnEvent extends Event {

	Player player;
	int phase;

	boolean mousePrev, queueRefresh;

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
				addEvent(new MoveRobberEvent(player));
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
			queueRefresh = true;

		} else if (phase == 2) { // we are in the build phase

			if (queueRefresh) {
				refreshHighlights(player);
			}

			queueRefresh = true;

			Container hov = VIEWPORT.getLowestHovered(mouseX, mouseY);

			if (!mousePressed && mousePrev && hov != null) {

				if (hov.id.equals("ROAD_BUY") && hov.highlighted) {
					addEvent(new AddRoadEvent(player, false));

				} else if (hov.id.equals("SETTLEMENT_BUY") && hov.highlighted) {
					addEvent(new AddSettlementEvent(player, false));

				} else if (hov.id.equals("CITY_BUY") && hov.highlighted) {
					addEvent(new AddCityEvent(player));

				} else if (hov.id.equals("SCRATCHY_STACK") && hov.highlighted) {
					RemoveCardsEvent rm = new RemoveCardsEvent();
					rm.addCards((CardArray)player.contents.getChild("CARDS"), card_cost);
					addEvent(rm);
					addEvent(new AddCardEvent(player, DECK.remove(DECK.size()-1)));

				} else if (hov instanceof ResourceCard && hov.parent == CARDS && hov.highlighted) { // resource card
					addEvent(new TradeResourceEvent(player, ((ResourceCard)hov).resource));

				} else queueRefresh = false;
			} else queueRefresh = false;
			
			if (keyPressed) {
				if (key == ENTER) {
					close();
				}
			}

			mousePrev = mousePressed;
		}
	}
}