class AddCardEvent extends Event {

	CardArray destination;
	Card item;

	float sx, sy, dx, dy;
	long timer, maxtimer;
	boolean steal;

	AddCardEvent() {} // empty super constructor

	AddCardEvent(Player p, Resource r) {
		Card source = (Card)CARDS.getChild(r.getStackName());
		item = new ResourceCard(r.cardImageName(), source.absX(), source.absY()+CARD_WIDTH, r);
		item.rotated = true;
		destination = (CardArray)p.contents.getChild("CARDS");
	}

	AddCardEvent(Player p, CardType c) {
		Card source = (Card)CARDS.getChild("SCRATCHY_STACK");
		item = new DevelopmentCard("scratchy_card", source.absX(), source.absY()+CARD_WIDTH, c);
		item.rotated = true;
		destination = (CardArray)p.contents.getChild("DEVCARDS");
	}

	void load() {
		sx = item.x;
		sy = item.y;
		if (destination.parent.active) { // we are giving to an active player
			dx = destination.absX()-sx;
			dy = destination.absY()-sy;

			for (int i = 0; i < destination.children.size(); i++) {
				if (item instanceof ResourceCard && ((ResourceCard)destination.children.get(i)).resource == ((ResourceCard)item).resource)
					break;
				dx += CARD_WIDTH/3;
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
			item.rotation = -HALF_PI*(1-frac);
			timer += DT;
		}
	}
}

static final int[] settlement_cost = {1, 1, 0, 1, 1};
static final int[] city_cost = {0, 0, 3, 2, 0};
static final int[] road_cost = {1, 0, 0, 0, 1};
static final int[] card_cost = {0, 1, 1, 1, 0};

class RemoveCardsEvent extends Event {

	ArrayList<Card> cards;
	CardArray array;
	float sy;;
	long timer, maxtimer;

	RemoveCardsEvent() {
		cards = new ArrayList<Card>();
	}

	void addCard(Card card) {
		cards.add(card);
	}

	// {brick, wool, ore, wheat, wood}
	void addCards(CardArray array, int[] resources) {
		int[] copy = new int[5];
		for (int i = 0; i < 5; i++) copy[i] = resources[i];
		resources = copy;
		for (Container c : array.children) {
			if (c instanceof ResourceCard) {
				if (((ResourceCard)c).resource == Resource.BRICK && resources[0] > 0) {
					resources[0]--;
					addCard((Card)c);
				}
				if (((ResourceCard)c).resource == Resource.WOOL && resources[1] > 0) {
					resources[1]--;
					addCard((Card)c);
				}
				if (((ResourceCard)c).resource == Resource.ORE && resources[2] > 0) {
					resources[2]--;
					addCard((Card)c);
				}
				if (((ResourceCard)c).resource == Resource.WHEAT && resources[3] > 0) {
					resources[3]--;
					addCard((Card)c);
				}
				if (((ResourceCard)c).resource == Resource.WOOD && resources[4] > 0) {
					resources[4]--;
					addCard((Card)c);
				}
			}
		}
	}

	void load() {
		maxtimer = 500;
		timer = 0;
		sy = cards.get(0).y;
		array = (CardArray)(cards.get(0).parent);
	}

	void tick() {
		if (timer > maxtimer) {
			for (Card c : cards) array.children.remove(c);
			array.refresh();
			close();
		} else {
			for (Card c : cards) {
				c.y = array.parent.h*(((float)timer)/maxtimer);
			}
			timer += DT;
		}
	}
}

class StealCardEvent extends AddCardEvent {

	StealCardEvent(Player p) { // steal a random card from SELECTED_PLAYER
		destination = (CardArray)p.contents.getChild("CARDS");
	}

	StealCardEvent(Player p, Card c) {
		destination = (CardArray)p.contents.getChild("CARDS");
		item = c;
	}

	void load() {
		Container source;
		if (item == null) {
			source = SELECTED_PLAYER.contents.getChild("CARDS");
			item = (Card)source.children.get((int)(Math.random()*source.children.size()));
		} else {
			source = item.parent;
		}
		source.children.remove(item);
		((CardArray)source).refresh();
		item.x = width/2;
		item.y = -CARD_WIDTH*2;
		super.load();
	}
}