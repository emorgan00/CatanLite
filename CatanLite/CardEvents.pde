class MonopolyEvent extends Event {

	Player player;
	boolean mousePrev;

	MonopolyEvent(Player p) {
		player = p;
	}

	void load() {
		clearHighlights();
		for (Container c : CARDS.children) {
			if (!c.id.equals("SCRATCHY_STACK")) c.highlight();
		}
	}

	void tick() {
		Container hov = VIEWPORT.getLowestHovered(mouseX, mouseY);

		if (!mousePressed && mousePrev && hov.highlighted) {
			for (Player p : PLAYERS) {
				if (p == player) continue;
				for (Container c : p.contents.getChild("CARDS").children) {
					if (((ResourceCard)c).resource == ((ResourceCard)hov).resource) {
						addEvent(new StealCardEvent(player, (Card)c));
					}
				}
			}
			refreshHighlights(player);
			close();
		}
		mousePrev = mousePressed;
	}
}

class FreeCardEvent extends Event {

	Player player;
	boolean mousePrev;

	FreeCardEvent(Player p) {
		player = p;
	}

	void load() {
		clearHighlights();
		for (Container c : CARDS.children) {
			if (!c.id.equals("SCRATCHY_STACK")) c.highlight();
		}
	}

	void tick() {
		Container hov = VIEWPORT.getLowestHovered(mouseX, mouseY);

		if (!mousePressed && mousePrev && hov.highlighted) {
			refreshHighlights(player);
			addEvent(new AddCardEvent(player, ((ResourceCard)hov).resource));
			close();
		}
		mousePrev = mousePressed;
	}
}