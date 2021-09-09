import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<MultiShape> shapes;
Boundary boundary;
void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);

  boundary = new Boundary(320,300,400,10);
  shapes = new ArrayList<MultiShape>();
}
void draw() {
  background(255);
  boundary.display();
  if (mousePressed) {
    MultiShape s = new MultiShape(10,mouseX,mouseY);
    shapes.add(s);
  }
  for (MultiShape s: shapes) {
    s.display();
  }
  box2d.step();
}
