import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

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
Surface surface;
ArrayList<Mover> movers;
void setup() {
  size(500,300);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Make a Surface object.
  surface = new Surface();
  movers = new ArrayList<Mover>();
}

void draw() {
  box2d.step();

  background(255);
  if (mousePressed) {
    Mover m = new Mover(8,width/2,0);
    movers.add(m);
  }
  for (Mover m: movers) {
    m.display();
  }
  // Draw the Surface.
  surface.display();
}
