import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Particle> particles;
Windmill windmill;
void setup() {
  size(640,360);
  smooth();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);

  particles = new ArrayList<Particle>();
  windmill = new Windmill(width/2,height-50);
}
void draw() {
  background(255);
  
  if (mousePressed) {
    Particle p = new Particle(mouseX,mouseY);
    particles.add(p);
  }
  for (Particle p: particles) {
    p.display();
  }
  windmill.display();
  box2d.step();
}
