class Tile extends GameObject {
  
  Resource resource;
  int value;
  ArrayList<Vertex> neighbors;
  boolean hasRobber;
  
  PShape hex;
  
  Tile(String id, float x, float y) {
    super(id,x,y);
    resource = new Resource();
    value = 0;
    neighbors = new ArrayList<Vertex>();
    hasRobber = false;
  }
  
  //creates a regular hexagon centered at (x,y)
  void createHex(int length) {
    hex = createShape();
    hex.beginShape();
    hex.vertex(x-length/2,y-length*0.8660254);
    hex.vertex(x+length/2,y-length*0.8660254);
    hex.vertex(x+length,y);
    hex.vertex(x+length/2,y+length*0.8660254);
    hex.vertex(x-length/2,y+length*0.8660254);
    hex.vertex(x-length,y);
    hex.endShape(CLOSE);
    shape(hex,x,y);
  }
}
