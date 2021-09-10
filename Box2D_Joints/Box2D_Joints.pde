import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Pair> pair;
Boundary boundary;
void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);

  boundary = new Boundary(320,300,400,10);
  pair = new ArrayList<Pair>();
}
void draw() {
  background(255);
  boundary.display();
  
  if (mousePressed) {
    Pair p = new Pair(random(0,width),random(0,height));
    pair.add(p);
  }
  for (Pair p: pair) {
    p.display();
  }
  
  box2d.step();
}
