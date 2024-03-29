class MoveRobberEvent extends Event {

	boolean selected, mousePrevious;
	float source_x, source_y;
	Container source_tile;
	Player player;

	MoveRobberEvent(Player p) {
		player = p;
	}

	void load() {
		selected = false;
		mousePrevious = false;
		source_x = ROBBER.x;
		source_y = ROBBER.y;
		source_tile = ROBBER.parent;
	}

	void tick() {
		
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);

		if (!mousePressed && mousePrevious) { // mouse up

			if (selected) {
				selected = false;
				ROBBER.parent.children.remove(ROBBER);

				if (hov instanceof Tile && hov != source_tile) { // move the robber from its old tile onto the new tile
					hov.addChild(ROBBER);
					ArrayList<Player> victims = new ArrayList<Player>();
					for (Vertex v : ((Tile)hov).vertices) {
						if (v.owner != null && v.owner != player && !victims.contains(v.owner) && v.owner.contents.getChild("CARDS").children.size() > 0) {
							victims.add(v.owner);
						}
					}
					if (victims.size() > 0) {
						addEvent(new StealCardEvent(player)); // stealing the card
						SelectPlayerEvent select = new SelectPlayerEvent(player+", choose someone to rob:", false);
						for (Player p : victims) select.addPlayer(p);
						addEvent(select);
					}
					close();
				} else { // put the robber back on its original tile
					source_tile.addChild(ROBBER);
				}

				// unzoom the robber
				ROBBER.resize(ROBBER.w/1.2, ROBBER.h/1.2);
				ROBBER.x = source_x;
				ROBBER.y = source_y;
			} else if (hov == ROBBER) {
				selected = true;
				ROBBER.detach();
				// zoom the robber a little
				ROBBER.x -= ROBBER.w*0.1;
				ROBBER.y -= ROBBER.h*0.1;
				ROBBER.resize(ROBBER.w*1.2, ROBBER.h*1.2);
			}
		}
		mousePrevious = mousePressed;

		// move the robber with the mouse
		if (selected) {
			ROBBER.x += mouseX-pmouseX;
			ROBBER.y += mouseY-pmouseY;
		}
	}

}