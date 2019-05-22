class AddSettlementEvent extends Event {
	
	Player player;
	Vertex dummy;
	boolean mousePrevious;
	
	AddSettlementEvent(Player player) {
		this.player = player;
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
		if (hov instanceof Vertex && ((Vertex)hov).owner == null) {
			dummy.x = hov.absX()-dummy.w*0.08;
			dummy.y = hov.absY()-dummy.h*0.08;
			if (!mousePressed && mousePrevious) {
				VIEWPORT.children.remove(dummy);
				((Vertex)hov).hasSettlement = true;
				hov.setImage("settlement");
				((Vertex)hov).owner = player;
				close();
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
	
	void load() {
		Vertex v = BOARD.vertices.get(0);
		dummy = new Vertex("DUMMY", mouseX, mouseY, v.w*1.2);
		VIEWPORT.addChild(dummy);
		dummy.setImage("city");
		dummy.owner = player;
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
		if (hov instanceof Vertex && ((Vertex)hov).owner == player && ((Vertex)hov).hasSettlement) {
			dummy.x = hov.absX()-dummy.w*0.08;
			dummy.y = hov.absY()-dummy.h*0.08;
			if (!mousePressed && mousePrevious) {
				VIEWPORT.children.remove(dummy);
				((Vertex)hov).hasSettlement = false;
				((Vertex)hov).hasCity = true;
				hov.setImage("city");
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
	Container road;
	boolean mousePrevious;
	
	AddRoadEvent(Player player) {
		this.player = player;
	}
	
	void load() {
		Link l = BOARD.links.get(0);
		road = new Container("dummy",mouseX,mouseY,l.w,l.h);
		VIEWPORT.addChild(road);
		road.setImage("road_h");
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
		
		road.x = mouseX;
		road.y = mouseY;
		if (!mousePressed && mousePrevious) {
			if (hov instanceof Link && !((Link)hov).hasRoad) {
				VIEWPORT.children.remove(road);
				((Link)hov).hasRoad = true;
				if (((Link)hov).type == LinkType.HORIZONTAL) {
					hov.setImage("road_h");
				}
				else if (((Link)hov).type == LinkType.POSITIVE) {
					hov.setImage("road_p");
				}
				else {
					hov.setImage("road_n");
				}
				close();
			}
		}
		mousePrevious = mousePressed;
	}
}
