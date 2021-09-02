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
  void update() {
    PVector mouse = new PVector(mouseX,mouseY);
    PVector dir = PVector.sub(mouse,location);
    dir.normalize();
    dir.mult(0.5);
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(8);
    location.add(velocity);
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
    acceleration = new PVector(-0.001,0.01);
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
Mover[] movers = new Mover[20];
void setup() {
  size(640, 360); // x,y
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
  //PVector v = new PVector(1,5);
  //PVector u = PVector.mult(v,2);
  //PVector w = PVector.sub(v,u);
  //println(v.x,v.y);
  //println(u.x,u.y);
  //println(w.x,w.y);
}
void draw() {
  background(244);
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
  }
}
