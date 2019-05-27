class Card extends Container {

	Card(String id, float x, float y) {
		super(id, x, y, CARD_WIDTH, CARD_WIDTH*1.478);
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

	DevelopmentCard(String id, float x, float y, CardType tpye) {
		super(id, x, y);
		this.type = type;
		setImage(type.imageName());
	}
}