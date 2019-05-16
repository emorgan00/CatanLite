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

	// search through all direct children to find the desired child.
	GameObject getChild(String id) {
		for (GameObject child : children) {
			if (child.id == id) return child;
		}
		return null;
	}

	// recursively search through all descendants to find the desired child.
	GameObject findChild(String id) {
		GameObject check;
		for (GameObject child : children) {
			if (child.id == id) return child;
			check = child.findChild(id);
			if (check != null) return check;
		}
		return null;
	}

	// return the frontmost object which is currently being hovered.
	// returning <this> is allowed.
	GameObject getLowestHovered() {
		for (GameObject child : children) {
			if (child.isHovered()) {
				return child.getLowestHovered();
			}
		}
		if isHovered() return this;
		return null;
	}

}