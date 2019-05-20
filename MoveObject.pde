class MoveRobberEvent extends Event {

	boolean selected, mousePrevious;
	float source_x, source_y;

	MoveRobberEvent() {
		selected = false;
		mousePrevious = false;
		source_x = ROBBER.x;
		source_y = ROBBER.y;
	}

	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);

		// check if the mouse has been interacted with
		if (mousePressed && !mousePrevious) { // mouse down
			if (hov == ROBBER) selected = true;
		} else if (!mousePressed && mousePrevious) { //mouse up
			selected = false;
			if (hov instanceof Tile) { // move the robber from its old tile onto the new tile
				ROBBER.parent.children.remove(ROBBER);
				hov.addChild(ROBBER);
				close();
			}
			ROBBER.x = source_x;
			ROBBER.y = source_y;
		}
		mousePrevious = mousePressed;

		// move the robber with the mouse
		if (selected) {
			ROBBER.x += mouseX-pmouseX;
			ROBBER.y += mouseY-pmouseY;
		}
	}

}