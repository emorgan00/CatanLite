abstract class GameObject {

	float x, y;
	String id;

	ArrayList<GameObject> children;
	GameObject parent;

	GameObject(float x, float y, String id, GameObject parent) {
		this.x = x;
		this.y = y;
		this.id = id;
	}

}