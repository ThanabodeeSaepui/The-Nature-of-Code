import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Polygon> polygons;
Boundary boundary;
void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  
  polygons = new ArrayList<Polygon>();
  boundary = new Boundary(320,300,400,10);
}
void draw() {
  background(255);
  boundary.display();
  if (mousePressed) {
    Polygon m = new Polygon(width/2,0);
    polygons.add(m);
  }
  for (Polygon p: polygons) {
    p.display();
  }
  box2d.step();
}
