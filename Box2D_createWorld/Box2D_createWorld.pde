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
Box2DProcessing box2d;
ArrayList<Box> boxes;
void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  boxes = new ArrayList<Box>();
}
void draw() {
  background(255);
  if (mousePressed) {
    Box p = new Box();
    boxes.add(p);
  }
  for (Box b: boxes) {
    b.display();
  }
  box2d.step();
  //drawCircle();
}
void drawCircle() {
  background(200);
  Vec2 mouseWorld = box2d.coordPixelsToWorld(mouseX,mouseY);
  Vec2 pixelPos = box2d.coordWorldToPixels(mouseWorld);
  ellipse(pixelPos.x, pixelPos.y,16,16);
}
void Box2DBasic() {
  BodyDef bd = new BodyDef();  // define body
  Vec2 center = box2d.coordPixelsToWorld(width/2,height/2);
  bd.position.set(center);
  bd.fixedRotation = true;
  bd.linearDamping = 0.8;
  bd.angularDamping = 0.9;
  bd.bullet = true;
  
  Body body = box2d.createBody(bd);  // create body
  body.setLinearVelocity(new Vec2(0,3));
  body.setAngularVelocity(1.2);
  
  PolygonShape ps = new PolygonShape();  // define shape
  float box2Dw = box2d.scalarPixelsToWorld(150);
  float box2Dh = box2d.scalarPixelsToWorld(100);
  ps.setAsBox(box2Dw, box2Dh);
  
  FixtureDef fd = new FixtureDef();  // define fixture
  // define physic property
  fd.shape = ps;
  fd.friction = 0.3;
  fd.restitution = 0.5;
  fd.density = 1.0;
  
  body.createFixture(fd);
  body.createFixture(ps,1);
}
