static class PVector {
  float x;
  float y;
  static PVector add(PVector v1, PVector v2) {
    PVector v3 = new PVector(v1.x + v2.x, v1.y + v2.y);
    return v3;
  }
  static PVector sub(PVector v1, PVector v2) {
    PVector v3 = new PVector(v1.x - v2.x, v1.y - v2.y);
    return v3;
  }
  static PVector mult(PVector v1, float v2) {
    PVector v3 = new PVector(v1.x * v2, v1.y * v2);
    return v3;
  }
  PVector(float x_, float y_) {
    x = x_;
    y = y_;
  }
  void add(PVector v) {
    y = y + v.y;
    x = x + v.x;
  }
  void sub(PVector v) {
    x = x - v.x;
    y = y - v.y;
  }
  void mult(float n) {
   x = x * n;
   y = y * n;
  }
  void div(float n) {
  x = x / n;
  y = y / n;
  }
  float mag() {
    return sqrt(x*x + y*y);
  }
  void normalize() {
    float m = mag();
    if (m != 0) {
      div(m);
    }
  }
  void limit(float max) {
    if (this.mag() > max) {
      normalize();
      mult(max);
    }
  }
}
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  void update() {
    //PVector mouse = new PVector(mouseX,mouseY);
    //PVector dir = PVector.sub(mouse,location);
    //dir.normalize();
    //dir.mult(0.5);
    //acceleration = dir;
    velocity.add(acceleration);
    //velocity.limit(8);
    location.add(velocity);
    acceleration = PVector.mult(acceleration,0);
  }
  void applyForce(PVector force) {
    force.div(mass);
    acceleration = force;
  }
  void display() {
    stroke(0);
    fill(175);
    // The Mover is displayed.
    ellipse(location.x,location.y,40,40);
  }
  Mover() {
    location = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 10.0;
  }
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
int height = 360;
int width = 640;
Mover mover;
Mover m1,m2;
void setup() {
  size(640, 360); // x,y
  mover = new Mover();
  m1 = new Mover();
  m2 = new Mover();
  
}
void draw() {
  if (mousePressed) {
    PVector wind = new PVector(0.5,0);
    mover.applyForce(wind);
  }
  //else {
  //  PVector wind = new PVector(-0.5,0);
  //  mover.applyForce(wind);
  //}
  background(204);
  mover.update();
  m1.update();
  m2.update();
  mover.checkEdges();
  m1.checkEdges();
  m2.checkEdges();
  mover.display();
  m1.display();
  m2.display();
  PVector wind = new PVector(1,0);
  m1.applyForce(wind);
  m2.applyForce(wind);
}
