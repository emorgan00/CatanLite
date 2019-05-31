class Card extends Container {

	boolean rotated;
	float rotation;

	Card(String id, float x, float y) {
		super(id, x, y, CARD_WIDTH, CARD_WIDTH*1.478);
	}

	void draw(float x, float y) {
		if (!rotated) super.draw(x, y);
		else if (img != null) {
			pushMatrix();
			translate(x+this.x, y+this.y);
			rotate(rotation);
			image(img, 0, 0);
			popMatrix();
		}
	}
}

class ResourceCard extends Card {

	Resource resource;

	ResourceCard(String id, float x, float y, Resource resource) {
		super(id, x, y);
		this.resource = resource;
		setImage(resource.cardImageName());
	}
}

class DevelopmentCard extends Card {

	CardType type;

	DevelopmentCard(String id, float x, float y, CardType type) {
		super(id, x, y);
		this.type = type;
		setImage(type.imageName());
	}
}

class CardArray extends Container {

	CardArray(String id, float x, float y) {
		super(id, x, y, 0, CARD_WIDTH*1.478);
	}

	void addChild(Container child) {
		if (!(child instanceof Card)) {
			throw new IllegalArgumentException("CardArray can only accept Cards as children");
		} if (child instanceof DevelopmentCard) {
			children.add(child);
		} else {
			boolean added = false;
			for (int i = 0; i < children.size(); i++) {
				if (children.get(i) instanceof DevelopmentCard) {
					children.add(i, child);
					added = true;
					break;
				} if (((ResourceCard)children.get(i)).resource == ((ResourceCard)child).resource) {
					children.add(i, child);
					added = true;
					break;
				}
			}
			if (!added) children.add(child);
		}
		child.parent = this;
		refresh();
	}

	void refresh() {
		boolean reached_gap = false;
		float card_x = 0;
		for (Container c : children) {
			if (c instanceof DevelopmentCard && !reached_gap) {
				card_x += CARD_WIDTH;
				reached_gap = true;
			}
			c.x = card_x;
			c.y = 0;
			card_x += CARD_WIDTH/3;
		}
		w = card_x+CARD_WIDTH*0.667;
	}

	Container getLowestHovered(float mx, float my) {
		float rx = mx-this.x;
		float ry = my-this.y;
		for (int j = children.size()-1; j > -1; j--) {
			Container child = children.get(j);
			if (child.isHovered(rx, ry)) {
				return child.getLowestHovered(rx, ry);
			}
		}
		if (isHovered(mx, my)) return this;
		return null;
	}

	// {brick, wool, ore, wheat, wood}
	int[] resources() {
		int[] out = new int[5];
		for (Container c : children) {
			if (c instanceof ResourceCard) {
				if (((ResourceCard)c).resource == Resource.BRICK) out[0]++;
				if (((ResourceCard)c).resource == Resource.WOOL) out[1]++;
				if (((ResourceCard)c).resource == Resource.ORE) out[2]++;
				if (((ResourceCard)c).resource == Resource.WHEAT) out[3]++;
				if (((ResourceCard)c).resource == Resource.WOOD) out[4]++;
			}
		}
		return out;
	}

}