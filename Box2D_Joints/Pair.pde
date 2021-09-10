class Pair {

  //[full] Two objects that each have a Box2D body
  Particle p1;
  Particle p2;
  //[end]
  // Arbitrary rest length
  float len = 32;

  Pair(float x, float y) {

    //[full]
    // Problems can result if the bodies are initialized at the same location.

    p1 = new Particle(x,y);
    p2 = new Particle(x+random(-1,1),y+random(-1,1));
    //[end]

    // Making the joint!
    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = p1.body;
    djd.bodyB = p2.body;
    djd.length = box2d.scalarPixelsToWorld(len);
    djd.frequencyHz = 0;  // Try a value less than 5
    djd.dampingRatio = 0; // Ranges between 0 and 1

    //[offset-down] Make the joint.  Note that we aren't storing a reference to the joint anywhere! We might need to someday, but for now it's OK.
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
  }

  void display() {
    Vec2 pos1 = box2d.getBodyPixelCoord(p1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(p2.body);
    stroke(0);
    line(pos1.x,pos1.y,pos2.x,pos2.y);

    p1.display();
    p2.display();
  }
}
