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
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
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
    movers[i] = new Mover(random(1,3),30,30);
  }
}
void draw() {
  background(234);
  
  PVector wind = new PVector(0.01,0);
  for (int i = 0; i < movers.length; i++) {
    float c = 0.01;
    PVector friction = movers[i].velocity.get();
    float m = movers[i].mass;
    PVector gravity = new PVector(0,0.1*m);
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    
    movers[i].applyForce(friction);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
