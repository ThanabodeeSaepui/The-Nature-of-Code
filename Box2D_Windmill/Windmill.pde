class Windmill {

  // Our “Windmill” is two boxes and one joint.
  RevoluteJoint joint;
  Box box1;
  Box box2;

  Windmill(float x, float y) {
    box1 = new Box(x,y-30,120,10,false);
    box2 = new Box(x,y,10,60,true);

    RevoluteJointDef rjd = new RevoluteJointDef();
    
    rjd.initialize(box1.body, box2.body, box1.body.getWorldCenter());

    rjd.motorSpeed = PI*2;
    rjd.maxMotorTorque = 1000.0;
    rjd.enableMotor = true;

    joint = (RevoluteJoint) box2d.world.createJoint(rjd);
  }

  void toggleMotor() {
    boolean motorstatus = joint.isMotorEnabled();
    joint.enableMotor(!motorstatus);
  }

  void display() {
    box1.display();
    box2.display();
    Vec2 anchor = box2d.coordWorldToPixels(box1.body.getWorldCenter());
    fill(255, 0, 0);
    stroke(0);
    ellipse(anchor.x, anchor.y, 4, 4);
  }
}
