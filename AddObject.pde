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

			boolean isAble = true;
			for (Link l : ((Vertex)hov).links) {
				for (Vertex v : l.vertices) {
					if (v != hov && v.owner != null) isAble = false;;
				}
			}

			if (isAble) {
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

			boolean isAble = true;
			for (Link l : ((Vertex)hov).links) {
				for (Vertex v : l.vertices) {
					if (v != hov && v.owner != null) isAble = false;;
				}
			}

			if (isAble) {
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
	boolean mousePrevious;
	
	AddRoadEvent(Player player) {
		this.player = player;
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
		if (hov instanceof Link && ((Link)hov).owner == null) {
			boolean isAble = false;
			for (int x = 0; x < ((Link)hov).vertices.size(); x++) {
				if (((Link)hov).vertices.get(x).owner == player) {
					isAble = true;
				}
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