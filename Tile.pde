class Tile extends GameObject {
  
  //Resource resource;
  int value;
  //ArrayList<Vertex> neighbors;
  boolean hasRobber;
  
  PShape hex;
  float len;
  
  Tile(String id, float x, float y, float len) {
    super(id,x,y);
    //resource = new Resource();
    value = 0;
    //neighbors = new ArrayList<Vertex>();
    hasRobber = false;
    this.len = len;
  }
  
  //creates a regular hexagon centered at (x,y) with side length of len
  void createHex(float x, float y) {
    hex = createShape();
    hex.beginShape();
    hex.vertex(x-len/2,y-len*0.8660254);
    hex.vertex(x+len/2,y-len*0.8660254);
    hex.vertex(x+len,y);
    hex.vertex(x+len/2,y+len*0.8660254);
    hex.vertex(x-len/2,y+len*0.8660254);
    hex.vertex(x-len,y);
    hex.endShape(CLOSE);
    shape(hex,x,y);
  }
  
  void draw(float x, float y) {
    if (isHovered(mouseX,mouseY)) fill(255, 0, 0, 32);
    else fill(0, 0, 0, 0);
    createHex(this.x+x,this.y+y);
  }
  
  //checks whether mouse is within the bounding square
  boolean isHovered(float mx, float my) {
    return mx > x-len && mx < x+len && my > y-len*0.8660254 && my < y+len*0.8660254;
  }
  
  //fill in later
  void click() {}
}
