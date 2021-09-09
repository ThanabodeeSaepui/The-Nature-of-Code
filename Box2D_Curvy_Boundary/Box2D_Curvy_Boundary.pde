import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
class Chain {
  Body body;
  float w;
  float h;
  Chain() {
    w = 16;
    h = 16;

    // Build body.
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(mouseX,mouseY));
    body = box2d.createBody(bd);

    // Build shape.
    ChainShape chain = new ChainShape();
    Vec2[] vertices = new Vec2[2];
    vertices[0] = box2d.coordPixelsToWorld(0,150);
    vertices[1] = box2d.coordPixelsToWorld(width,150);
    chain.createChain(vertices, vertices.length);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = chain;
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
class Surface {
  ArrayList<Vec2> surface;

  Surface() {
    surface = new ArrayList<Vec2>();
    //[full] 3 vertices in pixel coordinates
    surface.add(new Vec2(0, height/2+50));
    surface.add(new Vec2(width/2, height/2+50));
    surface.add(new Vec2(width, height/2));
    //[end]

    ChainShape chain = new ChainShape();

    // Make an array of Vec2 for the ChainShape.
    Vec2[] vertices = new Vec2[surface.size()];

    for (int i = 0; i < vertices.length; i++) {
      //[offset-up] Convert each vertex to Box2D World coordinates.
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }

    // Create the ChainShape with array of Vec2.
    chain.createChain(vertices, vertices.length);

    //[full] Attach the Shape to the Body.
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);
    //[end]
  }
  void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    //[full] Draw the ChainShape as a series of vertices.
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x,v.y);
    }
    //[end]
    endShape();
  }
}
Box2DProcessing box2d;
ArrayList<Chain> chains;
Surface surface;
void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  chains = new ArrayList<Chain>();
  surface = new Surface();
}
void draw() {
  box2d.step();
  background(255);
  if (mousePressed) {
    Chain p = new Chain();
    chains.add(p);
  }
  for (Chain c: chains) {
    c.display();
  }
  surface.display();
}
