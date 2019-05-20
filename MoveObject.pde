class MoveRobberEvent extends Event {

	boolean selected, mousePrevious;
	float source_x, source_y;
	Container source_tile;

	MoveRobberEvent() {
		selected = false;
		mousePrevious = false;
		source_x = ROBBER.x;
		source_y = ROBBER.y;
		source_tile = ROBBER.parent;
	}

	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);

		// check if the mouse has been interacted with
		if (mousePressed && !mousePrevious) { // mouse down
			if (hov == ROBBER) {
				selected = true;
				ROBBER.x = ROBBER.absX();
				ROBBER.y = ROBBER.absY();
				ROBBER.parent.children.remove(ROBBER);
				VIEWPORT.addChild(ROBBER);
			}
		} else if (!mousePressed && mousePrevious) { //mouse up
			selected = false;
			ROBBER.parent.children.remove(ROBBER);
			if (hov instanceof Tile && hov != source_tile) { // move the robber from its old tile onto the new tile
				hov.addChild(ROBBER);
				close();
			} else { // put the robber back on its original tile
				source_tile.addChild(ROBBER);
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