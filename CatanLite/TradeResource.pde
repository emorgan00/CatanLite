class TradeResourceEvent extends Event {

	Player player;
	Resource resource;
	CardArray cards;

	boolean mousePrev;

	TradeResourceEvent(Player p, Resource r) {
		player = p;
		resource = r;
	}

	void load() {
		clearHighlights();
		cards = (CardArray)(player.contents.getChild("CARDS"));
		int[] hand = cards.resources();
		for (Resource sell : Resource.values()) {
			if (sell == Resource.DESERT) continue;
			if (hand[sell.order()] >= player.tradeRatio(resource, sell)) {
				for (Container card : cards.children) {
					if (((ResourceCard)card).resource == sell) card.highlight();
				}
			}
		}
	}

	void tick() {
		Container hov = VIEWPORT.getLowestHovered(mouseX, mouseY);

		if (!mousePressed && mousePrev && hov.parent == cards && hov.highlighted) {
			Resource sell = ((ResourceCard)hov).resource;

			RemoveCardsEvent rm = new RemoveCardsEvent();
			int[] trade_cost = new int[5];
			trade_cost[sell.order()] = player.tradeRatio(resource, sell);
			rm.addCards(cards, trade_cost);
			addEvent(rm);

			addEvent(new AddCardEvent(player, resource));

			for (Container card : cards.children) card.unhighlight();
			close();
		}
		mousePrev = mousePressed;
	}

}