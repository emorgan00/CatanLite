abstract class GameObject {

	float x, y;
	String id;

	ArrayList<GameObject> children;
	GameObject parent;

	GameObject(float x, float y, String id, GameObject parent) {
		this.x = x;
		this.y = y;
		this.id = id;
		this.parent = parent;
	}

	void addChild(GameObject child) {
		this.children.add(child);
		child.parent = this;
	}

	GameObject getChild(String id) {
		for (GameObject child : children) {
			if (child.id == id) return child;
		}
		return null;
	}

	GameObject findChild(String id) {
		GameObject check;
		for (GameObject child : children) {
			if (child.id == id) return child;
			check = child.findChild(id);
			if (check != null) return check;
		}
		return null;
	}

}