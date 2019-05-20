class Player {
  int red;
  int green;
  int blue;
  
  ArrayList<Vertex> settlements;
  ArrayList<Vertex> cities;
  ArrayList<Link> roads;
  
  Player(int r, int g, int b) {
    red = r;
    green = g;
    blue = b;
    settlements = new ArrayList<Vertex>();
    cities = new ArrayList<Vertex>();
    roads = new ArrayList<Link>();
  }
  
  boolean addSettlement(String id) {
    Vertex v = (Vertex)BOARD.getChild(id);
    if (!v.hasSettlement && !v.hasCity) {
      settlements.add(v);
      v.hasSettlement = true;
      return true;
    }
    return false;
  }
  
  boolean addCity(String id) {
    Vertex v = (Vertex)BOARD.getChild(id);
    if (v.hasSettlement) {
      cities.add(v);
      settlements.remove(v);
      v.hasSettlement = false;
      v.hasCity = true;
      return true;
    }
    return false;
  }
  
  boolean addRoad(String id) {
    Link l = (Link)BOARD.getChild(id);
    if (!l.hasRoad) {
      roads.add(l);
      l.hasRoad = true;
      return true;
    }
    return false;
  }
}
