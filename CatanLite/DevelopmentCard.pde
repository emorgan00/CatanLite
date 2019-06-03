enum CardType {

	KNIGHT, ROAD_BUILDING, YEAR_OF_PLENTY, MONOPOLY, MARKET, UNIVERSITY, PALACE, CHAPEL, LIBRARY;

	String imageName() {
		if (this == KNIGHT) return "knight_"+(int)(Math.random()*3);
		else if (this == ROAD_BUILDING) return "road_building";
		else if (this == YEAR_OF_PLENTY) return "year_of_plenty";
		else if (this == MONOPOLY) return "monopoly";
		else if (this == MARKET) return "market";
		else if (this == UNIVERSITY) return "university";
		else if (this == PALACE) return "palace";
		else if (this == CHAPEL) return "chapel";
		else if (this == LIBRARY) return "library";
		else return "cardborder";
	}
}

class DevelopmentCard extends Card {

	CardType type;

	DevelopmentCard(String id, float x, float y, CardType type) {
		super(id, x, y);
		this.type = type;
		setImage(type.imageName());
	}

	String toString() {
		return super.toString()+"(type = "+type+")";
	}
}

void playCard(Player player, DevelopmentCard card) {

	if (card.type == CardType.KNIGHT) {

		addEvent(new MoveRobberEvent(player));
		addEvent(new MessageBoxEvent(player+" has played a Knight,\nand will now move the robber.", false));
		player.knights++;

	} else if (card.type == CardType.MONOPOLY) {

		addEvent(new MonopolyEvent(player));
		addEvent(new MessageBoxEvent(player+", please choose a resource to\ntake from all other players.", false));

	}

	RemoveCardsEvent rm = new RemoveCardsEvent();
	rm.addCard(card);
	addEvent(rm);
	for (Container c : player.contents.getChild("DEVCARDS").children) c.unhighlight();
}

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