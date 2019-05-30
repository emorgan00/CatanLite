class AddSettlementEvent extends Event {
	
	Player player;
	Vertex dummy;
	boolean mousePrevious, setup;
	
	AddSettlementEvent(Player player, boolean setup) {
		this.player = player;
		// in setup mode, settlements can go anywhere. otherwise, they need to be placed by a road.
		this.setup = setup;
	}

	String toString() {
		return super.toString()+"(Player = "+player+", setup = "+setup+")";
	}
	
	void load() {
		Vertex v = BOARD.vertices.get(0);
		dummy = new Vertex("DUMMY", mouseX, mouseY, v.w*1.2);
		VIEWPORT.addChild(dummy);
		dummy.setImage("settlement");
		dummy.owner = player;
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
    if (hov == null && !setup && !mousePressed && mousePrevious) {
      VIEWPORT.children.remove(dummy);
      close();
    }
		if (hov instanceof Vertex && ((Vertex)hov).owner == null) {

			boolean isAble = true;
			for (Link l : ((Vertex)hov).links) {
				for (Vertex v : l.vertices) {
					if (v != hov && v.owner != null) isAble = false;;
				}
			}

			if (!setup) {
				boolean roadFlag = false;
				for (Link l : ((Vertex)hov).links) {
					if (l.owner == player) roadFlag = true;
				}
				if (!roadFlag) isAble = false;
			}

			if (isAble) {
				dummy.x = hov.absX()-dummy.w*0.08;
				dummy.y = hov.absY()-dummy.h*0.08;

				if (!mousePressed && mousePrevious) {
					VIEWPORT.children.remove(dummy);
					((Vertex)hov).hasSettlement = true;
					hov.setImage("settlement");
					((Vertex)hov).owner = player;
          player.points++;
					close();
				}

			} else {
				dummy.x = mouseX-dummy.w/2;
				dummy.y = mouseY-dummy.h/2;
			}
		} else {
			dummy.x = mouseX-dummy.w/2;
			dummy.y = mouseY-dummy.h/2;
		}
		mousePrevious = mousePressed;
	}
}

class AddCityEvent extends Event {
	
	Player player;
	Vertex dummy;
	boolean mousePrevious;
	
	AddCityEvent(Player player) {
		this.player = player;
	}

	String toString() {
		return super.toString()+"(Player = "+player+")";
	}
	
	void load() {
		Vertex v = BOARD.vertices.get(0);
		dummy = new Vertex("DUMMY", mouseX, mouseY, v.w*1.2);
		VIEWPORT.addChild(dummy);
		dummy.setImage("city");
		dummy.owner = player;
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
    if (hov == null && !mousePressed && mousePrevious) {
      VIEWPORT.children.remove(dummy);
      close();
    }
		if (hov instanceof Vertex && ((Vertex)hov).owner == player && ((Vertex)hov).hasSettlement) {

			dummy.x = hov.absX()-dummy.w*0.08;
			dummy.y = hov.absY()-dummy.h*0.08;

			if (!mousePressed && mousePrevious) {
				VIEWPORT.children.remove(dummy);
				((Vertex)hov).hasSettlement = false;
				((Vertex)hov).hasCity = true;
				hov.setImage("city");
        player.points++;
				close();
			}

		} else {
			dummy.x = mouseX-dummy.w/2;
			dummy.y = mouseY-dummy.h/2;
		}
		mousePrevious = mousePressed;
	}
}

class AddRoadEvent extends Event {
	
	Player player;
	Link dummy, pastHov;
	boolean mousePrevious, setup;
	
	AddRoadEvent(Player player, boolean setup) {
		this.player = player;
		// in setup mode, roads need to go next to a settlement. otherwise, they need to be placed by another road.
		this.setup = setup;
	}

	String toString() {
		return super.toString()+"(Player = "+player+", setup = "+setup+")";
	}
	
	void load() {
		Link l = BOARD.links.get(0);
		dummy = new Link("DUMMY", mouseX, mouseY, mouseX+l.w*1.2, mouseY+l.h*1.2);
		VIEWPORT.addChild(dummy);
		dummy.setImage(l.type.imageName());
		dummy.owner = player;
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
    if (hov == null && !setup && !mousePressed && mousePrevious) {
      VIEWPORT.children.remove(dummy);
      close();
    }
		if (hov instanceof Link && ((Link)hov).owner == null) {

			boolean isAble = false;
			if (setup) {
				for (Vertex v : ((Link)hov).vertices) {
					if (v.owner == player) isAble = true;
				}
			} else {
				boolean roadFlag = false;
				for (Vertex v : ((Link)hov).vertices) {
					if (v.owner == player || v.owner == null) {
						for (Link l : v.links) {
							if (l != hov && l.owner == player) roadFlag = true;
						}
					}
				}
				if (roadFlag) isAble = true;
			}

			if (isAble) {
				if (hov != pastHov) {
					pastHov = ((Link)hov);
					dummy.w = ((Link)hov).w*1.2;
					dummy.h = ((Link)hov).h*1.2;
					dummy.setImage(((Link)hov).type.imageName());
				}
				dummy.x = hov.absX()-dummy.w*0.08;
				dummy.y = hov.absY()-dummy.h*0.08;

				if (!mousePressed && mousePrevious) {
					VIEWPORT.children.remove(dummy);
					((Link)hov).hasRoad = true;
					hov.setImage(((Link)hov).type.imageName());
					((Link)hov).owner = player;
					close();
				}
			} else {
				dummy.x = mouseX-dummy.w/2;
				dummy.y = mouseY-dummy.h/2;
			}
		} else {
			dummy.x = mouseX-dummy.w/2;
			dummy.y = mouseY-dummy.h/2;
		}
		mousePrevious = mousePressed;
	}
}