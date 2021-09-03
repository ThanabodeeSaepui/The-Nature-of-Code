import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;

void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
}
void draw() {
  BodyDef bd = new BodyDef();
  Vec2 center = box2d.coordPixelsToWorld(width/2,height/2);
  bd.position.set(center);
  bd.fixedRotation = true;
  bd.linearDamping = 0.8;
  bd.angularDamping = 0.9;
  bd.bullet = true;
  
  Body body = box2d.createBody(bd);
  body.setLinearVelocity(new Vec2(0,3));
  body.setAngularVelocity(1.2);
  
  PolygonShape ps = new PolygonShape();
  float box2Dw = box2d.scalarPixelsToWorld(150);
  float box2Dh = box2d.scalarPixelsToWorld(100);
  ps.setAsBox(box2Dw, box2Dh);
  
  FixtureDef fd = new FixtureDef();
  fd.shape = ps;
  fd.friction = 0.3;
  fd.restitution = 0.5;
  fd.density = 1.0;
  
  body.createFixture(fd);
  body.createFixture(ps,1);
  //drawCircle();
}
void drawCircle() {
  Vec2 mouseWorld = box2d.coordPixelsToWorld(mouseX,mouseY);
  Vec2 pixelPos = box2d.coordWorldToPixels(mouseWorld);
  ellipse(pixelPos.x, pixelPos.y,16,16);
}
