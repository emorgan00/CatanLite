class AddCardEvent extends Event {

	CardArray destination;
	Card item;

	float sx, sy, dx, dy;
	long timer, maxtimer;

	AddCardEvent(Player p, Resource r) {
		Card source = (Card)CARDS.getChild(r.getStackName());
		item = new ResourceCard(r.imageName(), source.absX(), source.absY(), r);
		item.rotated = true;
		destination = (CardArray)p.contents.getChild("CARDS");
	}

	void load() {
		sx = item.x;
		sy = item.y+CARD_WIDTH;
		if (destination.parent.active) { // we are giving to an active player
			dx = destination.absX()-sx;
			dy = destination.absY()-sy;
			if (item instanceof DevelopmentCard) sx += CARD_WIDTH;

			for (int i = 0; i < destination.children.size(); i++) {
				if (destination.children.get(i) instanceof DevelopmentCard)
					break;
				if (item instanceof ResourceCard && ((ResourceCard)destination.children.get(i)).resource == ((ResourceCard)item).resource)
					break;
				sx += CARD_WIDTH/3;
			}
		} else { // the player is inactive
			dx = width/2-sx;
			dy = -CARD_WIDTH*2-sy;
		}
		maxtimer = (long)(Math.hypot(dx, dy)/width*700);
		timer = 0;
		VIEWPORT.addChild(item);
	}

	void tick() {
		if (timer > maxtimer) {
			destination.addChild(item);
			VIEWPORT.children.remove(item);
			item.rotated = false;
			close();
		} else {
			float frac = ((float)timer)/maxtimer;
			item.x = sx+dx*frac;
			item.y = sy+dy*frac;
			item.rotation = HALF_PI*(1-frac);
			timer += DT;
		}
	}

}