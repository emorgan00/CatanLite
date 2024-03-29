class Container {

	float x, y, w, h;
	String id, img_name;
	PImage img;

	boolean active, rotated, highlighted;

	ArrayList<Container> children;
	Container parent;

	Container(String id, float x, float y, float w, float h) {
		this.id = id;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.children = new ArrayList<Container>();
		active = true;
	}

	String toString() {
		return id;
	}

	void addChild(Container child) {
		this.children.add(child);
		child.parent = this;
	}

	void setImage(String name) {
		img_name = name;
		this.img = getImage(name, w, h);
	}

	//	Search through all direct children to find the desired child.
	Container getChild(String id) {
		for (Container child : children) {
			if (child.id == id) return child;
		}
		return null;
	}

	//	Recursively search through all descendants to find the desired child.
	Container findChild(String id) {
		Container check;
		for (Container child : children) {
			if (child.id == id) return child;
			check = child.findChild(id);
			if (check != null) return check;
		}
		return null;
	}

	//	Return the frontmost object which is currently being hovered.
	//	Returning <this> is allowed.
	Container getLowestHovered(float mx, float my) {
		float rx = mx-this.x;
		float ry = my-this.y;
		for (Container child : children) {
			if (child.isHovered(rx, ry)) {
				return child.getLowestHovered(rx, ry);
			}
		}
		if (isHovered(mx, my)) return this;
		return null;
	}

	void display(float x, float y) {
		if (active) {
			draw(x, y);
			for (Container child : children) {
				child.display(x+this.x, y+this.y);
			}
		}
	}

	void draw(float x, float y) {
		if (img != null) image(img, x+this.x, y+this.y);
	}

	boolean isHovered(float mx, float my) {
		if (!active) return false;
		return mx > x && my > y && mx < x+w && my < y+h;
	}

	void debugDraw(float x, float y) {
		fill(255);
		text(id, x+this.x, y+this.y);
		if (isHovered(mouseX-x, mouseY-y)) fill(255, 0, 0, 16);
		else fill(0, 0, 0, 0);
		rect(x+this.x, y+this.y, w, h);
		for (Container child : children) {
			child.debugDraw(x+this.x, y+this.y);
		}
	}

	float absX() { // return the absolute x value of this relative to the viewport
		if (this == VIEWPORT) return 0;
		return x+parent.absX();
	}

	float absY() { // return the absolute y value of this relative to the viewport
		if (this == VIEWPORT) return 0;
		return y+parent.absY();
	}

	void detach() { // completely detach this object from everything else, add it to the viewport, preserving location
		x = absX();
		y = absY();
		parent.children.remove(this);
		VIEWPORT.addChild(this);
	}

	void resize(float w, float h) {
		this.w = w;
		this.h = h;
		setImage(img_name);
	}

	void flip() {
		float sto = w;
		w = h;
		h = sto;
		rotated = !rotated;
		if (rotated) setImage("rotated_"+img_name);
		else setImage(img_name.replace("rotated_", ""));
	}

	void highlight() {
		if (!highlighted) {
			x -= w*0.1;
			y -= h*0.1;
			w *= 1.2;
			h *= 1.2;
			setImage("highlighted_"+img_name);
			highlighted = true;
		}
	}

	void unhighlight() {
		if (highlighted) {
			w /= 1.2;
			h /= 1.2;
			x += w*0.1;
			y += h*0.1;
			setImage(img_name.replace("highlighted_", ""));
			highlighted = false;
		}
	}
}