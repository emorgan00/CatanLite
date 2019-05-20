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
}
