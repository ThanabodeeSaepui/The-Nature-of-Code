import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
class Box {
  Body body;
  float w;
  float h;
  Box() {
    w = 16;
    h = 16;

    // Build body.
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(mouseX,mouseY));
    body = box2d.createBody(bd);

    // Build shape.
    PolygonShape ps = new PolygonShape();
    //[full] Box2D considers the width and height of a rectangle to be the distance from the center to the edge (so half of what we normally think of as width or height).
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    //[end]
    ps.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    // Set physics parameters.
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Attach the Shape to the Body with the Fixture.
    body.createFixture(fd);
  }
  void display() {
    //[full] We need the Body’s location and angle.
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    //[end]

    pushMatrix();
    //[full] Using the Vec2 position and float angle to translate and rotate the rectangle
    translate(pos.x,pos.y);
    rotate(-a);
    //[end]
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  // This function removes a body from the Box2D world.
  void killBody() {
    box2d.destroyBody(body);
  }
}
class Boundary {

  //[full] A boundary is a simple rectangle with x, y, width, and height.
  float x,y;
  float w,h;
  //[end]
  Body b;

  Boundary(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Build the Box2D Body and Shape.
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    // Make it fixed by setting type to STATIC!
    bd.type = BodyType.STATIC;
    b = box2d.createBody(bd);

    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    PolygonShape ps = new PolygonShape();
    // The PolygonShape is just a box.
    ps.setAsBox(box2dW, box2dH);

    // Using the createFixture() shortcut
    b.createFixture(ps,1);
  }

  // Since we know it can never move, we can just draw it
  // the old-fashioned way, using our original
  // variables. No need to query Box2D.
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x,y,w,h);
  }
}
Box2DProcessing box2d;
ArrayList<Box> boxes;
Boundary boundary;
void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  boxes = new ArrayList<Box>();
  boundary = new Boundary(320,300,400,10);
}
void draw() {
  background(255);
  boundary.display();
  if (mousePressed) {
    Box p = new Box();
    boxes.add(p);
  }
  for (Box b: boxes) {
    b.display();
  }
  box2d.step();
}
