class AddSettlementEvent extends Event {
	
	Player player;
	Container settlement;
	boolean mousePrevious;
	
	AddSettlementEvent(Player player) {
		this.player = player;
	}
	
	void load() {
		Vertex v = BOARD.vertices.get(0);
		settlement = new Container("dummy",mouseX,mouseY,v.w,v.h);
		VIEWPORT.addChild(settlement);
		settlement.setImage("settlement");
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
		
		settlement.x = mouseX;
		settlement.y = mouseY;
		if (!mousePressed && mousePrevious) {
			if (hov instanceof Vertex && !((Vertex)hov).hasSettlement && !((Vertex)hov).hasCity) {
				VIEWPORT.children.remove(settlement);
				((Vertex)hov).hasSettlement = true;
				hov.setImage("settlement");
				close();
			}
		}
		mousePrevious = mousePressed;
	}
}

class AddCityEvent extends Event {
	Player player;
	Container city;
	boolean mousePrevious;
	
	AddCityEvent(Player player) {
		this.player = player;
	}
	
	void load() {
		Vertex v = BOARD.vertices.get(0);
		city = new Container("dummy",mouseX,mouseY,v.w,v.h);
		VIEWPORT.addChild(city);
		city.setImage("city");
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
		
		city.x = mouseX;
		city.y = mouseY;
		if (!mousePressed && mousePrevious) {
			if (hov instanceof Vertex && ((Vertex)hov).hasSettlement) {
				VIEWPORT.children.remove(city);
				((Vertex)hov).hasSettlement = false;
				((Vertex)hov).hasCity = true;
				hov.setImage("city");
				close();
			}
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
