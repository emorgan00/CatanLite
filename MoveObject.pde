class MoveRobberEvent extends Event {

	boolean selected, mousePrevious;
	float source_x, source_y;
	Container source_tile;

	void load() {
		selected = false;
		mousePrevious = false;
		source_x = ROBBER.x;
		source_y = ROBBER.y;
		source_tile = ROBBER.parent;
	}

	void tick() {
		
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);

		// check if the mouse has been interacted with
		if (mousePressed && !mousePrevious && hov == ROBBER) { // mouse down

			selected = true;
			ROBBER.detach();
			// zoom the robber a little
			ROBBER.x -= ROBBER.w*0.1;
			ROBBER.y -= ROBBER.h*0.1;
			ROBBER.resize(ROBBER.w*1.2, ROBBER.h*1.2);

		} else if (!mousePressed && mousePrevious && selected) { // mouse up

			selected = false;
			ROBBER.parent.children.remove(ROBBER);

			if (hov instanceof Tile && hov != source_tile) { // move the robber from its old tile onto the new tile
				hov.addChild(ROBBER);
				close();
			} else { // put the robber back on its original tile
				source_tile.addChild(ROBBER);
			}

			// unzoom the robber
			ROBBER.resize(ROBBER.w/1.2, ROBBER.h/1.2);
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