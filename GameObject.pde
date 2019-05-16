abstract class GameObject {

	float x, y;
	String id;

	ArrayList<GameObject> children;
	GameObject parent;

	GameObject(String id, float x, float y) {
		this.id = id;
		this.x = x;
		this.y = y;
		this.children = new ArrayList<GameObject>();
	}

	void addChild(GameObject child) {
		this.children.add(child);
		child.parent = this;
	}

	//	Search through all direct children to find the desired child.
	GameObject getChild(String id) {
		for (GameObject child : children) {
			if (child.id == id) return child;
		}
		return null;
	}

	//	Recursively search through all descendants to find the desired child.
	GameObject findChild(String id) {
		GameObject check;
		for (GameObject child : children) {
			if (child.id == id) return child;
			check = child.findChild(id);
			if (check != null) return check;
		}
		return null;
	}

	//	Return the frontmost object which is currently being hovered.
	//	Returning <this> is allowed.
	GameObject getLowestHovered(float mx, float my) {
		float rx = mx-this.x;
		float ry = my-this.y;
		for (GameObject child : children) {
			if (child.isHovered(rx, ry)) {
				return child.getLowestHovered(rx, ry);
			}
		}
		if (isHovered(mx, my)) return this;
		return null;
	}

	//	Draw this object onto the screen, with the origin at (x, y).
	abstract void draw(float x, float y);

	//	Return true if the mouse is inside the bounding-box of this object, with the mouse at (mx, my).
	abstract boolean isHovered(float mx, float my);

	//	Describes the behavior when this object is clicked.
	abstract void click();

	void debugDraw(float x, float y) {
		fill(255);
		text(id, x+this.x, y+this.y+10);
		stroke(255);
		if (isHovered(mouseX-x, mouseY-y)) fill(255, 0, 0, 32);
		else fill(0, 0, 0, 0);
	}

}