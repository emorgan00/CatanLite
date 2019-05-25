class Card extends Container {

	Card(String id, float x, float y, float w) {
		super(id, x, y, w, w*1.478);
	}

}

class ResourceCard extends Card {

	Resource resource;

	ResourceCard(String id, float x, float y, float w, Resource resource) {
		super(id, x, y, w);
		this.resource = resource;
		setImage(resource.cardImageName());
	}
}

class DevelopmentCard extends Card {

	CardType type;

	DevelopmentCard(String id, float x, float y, float w, CardType tpye) {
		super(id, x, y, w);
		this.type = type;
		setImage(type.imageName());
	}
}