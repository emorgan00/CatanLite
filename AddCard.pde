class AddCardEvent extends Event {

	CardArray destination;
	Card item;

	float stepx, stepy;
	int timer;

	AddCardEvent(Player p, Resource r) {
		Card source = (Card)CARDS.getChild(r.getStackName());
		item = new ResourceCard(r.imageName(), source.absX(), source.absY(), r);
		//item.flip();
		destination = (CardArray)p.contents.getChild("CARDS");
	}

	void load() {
		timer = 60;
		if (destination.parent.active) { // we are giving to an active player
			stepx = (destination.x-item.x)/timer;
			stepy = (destination.y-item.y)/timer;
		} else { // the player is inactive
			stepx = (width/2-item.x)/timer;
			stepy = (-100-item.y)/timer;
		}
		VIEWPORT.addChild(item);
	}

	void tick() {
		if (timer == 0) {
			if (destination.parent.active) destination.addChild(item);
			VIEWPORT.children.remove(item);
			close();
		} else {
			item.x -= stepx;
			item.y -= stepy;
			timer--;
		}
	}

}