class TradeResourceEvent extends Event {

	Player player;
	Resource resource;

	TradeResourceEvent(Player p, Resource r) {
		player = p;
		resource = r;
	}

	void load() {
		clearHighlights();
	}

	void tick() {
		refreshHighlights(player);
		close();
	}

}