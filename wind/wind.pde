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
  Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  void applyForce(PVector force) {
    force.div(mass);
    acceleration.add(force);
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration = PVector.mult(acceleration,0);
  }
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,mass*16,mass*16);
  }
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
}
int height = 360;
int width = 640;
Mover[] movers = new Mover[100];
void setup() {
  size(640, 360);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(1,1.5),30,30);
  }
}
void draw() {
  background(234);
  PVector wind = new PVector(0.01,0);
  PVector gravity = new PVector(0,0.1);
  for (int i = 0; i < movers.length; i++) {
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
