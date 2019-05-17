class Tile extends GameObject {
  
  Resource resource;
  int value;
  ArrayList<Vertex> neighbors;
  boolean hasRobber;
  
  Tile(String id, float x, float y) {
    super(id,x,y);
    resource = new Resource();
    value = 0;
    neighbors = new ArrayList<Vertex>();
    hasRobber = false;
  }
}
