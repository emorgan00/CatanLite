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
		float dx, dy;
		if (destination.parent.active) { // we are giving to an active player
			dx = destination.absX()-item.x;
			dy = destination.absY()-item.y;
		} else { // the player is inactive
			dx = width/2-item.x;
			dy = -CARD_WIDTH*2-item.y;
		}
		timer = (int)(Math.hypot(dx, dy)/width*20);
		stepx = dx/timer;
		stepy = dy/timer;
		VIEWPORT.addChild(item);
	}

	void tick() {
		if (timer == 0) {
			if (destination.parent.active) destination.addChild(item);
			VIEWPORT.children.remove(item);
			close();
		} else {
			item.x += stepx;
			item.y += stepy;
			timer--;
		}
	}

}