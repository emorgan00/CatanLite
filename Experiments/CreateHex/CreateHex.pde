PShape hex;
void setup() {
  size(400,400);
  fill(255);
}
void createHex(int x, int y, int length) {
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
void draw() {
  createHex(100,100,50);
}
