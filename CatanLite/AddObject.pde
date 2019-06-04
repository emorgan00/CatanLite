class AddSettlementEvent extends Event {
	
	Player player;
	Vertex dummy;
	boolean mousePrevious, setup, addResources;
	
	AddSettlementEvent(Player player, boolean setup, boolean addResources) {
		this.player = player;
		// in setup mode, settlements can go anywhere. otherwise, they need to be placed by a road.
		this.setup = setup;
		this.addResources = addResources;
	}
	
	AddSettlementEvent(Player player, boolean setup) {
		this.player = player;
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
		if (!setup) player.contents.getChild("SETTLEMENT_BUY").active = false;
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
		if (hov == null && !setup && !mousePressed && mousePrevious) {
			VIEWPORT.children.remove(dummy);
			close(true);
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
          player.settlements.add((Vertex)hov);
					if (addResources) {
						for (Tile t : ((Vertex)hov).tiles) {
							Resource r = t.resource;
							if (r == Resource.DESERT) continue;
							player.contents.getChild("CARDS").addChild(new ResourceCard(r.cardImageName(), 0, 0, r));
						}
					}
					close(false);
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

	void close(boolean cancel) {
		super.close();
		player.contents.getChild("SETTLEMENT_BUY").active = true;
		if (!setup && !cancel) {
			RemoveCardsEvent event = new RemoveCardsEvent();
			event.addCards((CardArray)player.contents.getChild("CARDS"), settlement_cost);
			addEvent(event);
		}
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
		player.contents.getChild("CITY_BUY").active = false;
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
		if (hov == null && !mousePressed && mousePrevious) {
			VIEWPORT.children.remove(dummy);
			close(true);
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
        player.cities.add((Vertex)hov);
				close(false);
			}

		} else {
			dummy.x = mouseX-dummy.w/2;
			dummy.y = mouseY-dummy.h/2;
		}
		mousePrevious = mousePressed;
	}

	void close(boolean cancel) {
		super.close();
		player.contents.getChild("CITY_BUY").active = true;
		if (!cancel) {
			RemoveCardsEvent event = new RemoveCardsEvent();
			event.addCards((CardArray)player.contents.getChild("CARDS"), city_cost);
			addEvent(event);
		}
	}
}

class AddRoadEvent extends Event {
	
	Player player;
	Link dummy, pastHov;
	boolean mousePrevious, setup, forced;
	
	AddRoadEvent(Player player, boolean setup) {
		this.player = player;
		// in setup mode, roads need to go next to a settlement. otherwise, they need to be placed by another road.
		this.setup = setup;
	}
	
	AddRoadEvent(Player player, boolean setup, boolean forced) {
		this.player = player;
		this.setup = setup;
		this.forced = forced;
	}

	String toString() {
		return super.toString()+"(Player = "+player+", setup = "+setup+")";
	}
	
	void load() {
		Link l = BOARD.links.get(2);
		dummy = new Link("DUMMY", mouseX, mouseY, mouseX+l.w*1.2, mouseY+l.h*1.2);
		VIEWPORT.addChild(dummy);
		dummy.setImage(l.type.imageName());
		dummy.owner = player;
		if (!setup) player.contents.getChild("ROAD_BUY").active = false;
	}
	
	void tick() {
		Container hov = BOARD.getLowestHovered(mouseX, mouseY);
		if (hov == null && !setup && !mousePressed && mousePrevious && !forced) {
			VIEWPORT.children.remove(dummy);
			close(true);
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
          player.roads.add((Link)hov);
					VIEWPORT.children.remove(dummy);
					((Link)hov).hasRoad = true;
					hov.setImage(((Link)hov).type.imageName());
					((Link)hov).owner = player;
					close(false);
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

	void close(boolean cancel) {
		super.close();
		player.contents.getChild("ROAD_BUY").active = true;
		if (!setup && !cancel && !forced) {
			RemoveCardsEvent event = new RemoveCardsEvent();
			event.addCards((CardArray)player.contents.getChild("CARDS"), road_cost);
			addEvent(event);
		}
	}
}
