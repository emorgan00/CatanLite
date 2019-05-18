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
    hex.vertex(x-len*0.8660254,y-len/2);
    hex.vertex(x-len*0.8660254,y+len/2);
    hex.vertex(x,y+len);
    hex.vertex(x+len*0.8660254,y+len/2);
    hex.vertex(x+len*0.8660254,y-len/2);
    hex.vertex(x,y-len);
    hex.endShape(CLOSE);
    shape(hex,x,y);
  }
  
  void draw(float x, float y) {
    if (isHovered(mouseX-x-this.x,mouseY-y-this.y)) fill(255, 0, 0, 32);
    else fill(0, 0, 0, 0);
    createHex(this.x+x,this.y+y);
  }
  
  //checks whether mouse is within the bounding square
  boolean isHovered(float mx, float my) {
    return my > y-len && my < y+len && mx > x-len*0.8660254 && mx < x+len*0.8660254;
  }
  
  //fill in later
  void click() {}
}
