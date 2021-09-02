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
    } else if (location.y < 0) {
      velocity.y *= -1;
      location.y = 0;
    }
  }
}
class Attractor {
  float mass;
  PVector location;
  float G;
  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 20;
    G = 4;
  }
  PVector attract(Mover m) {
    PVector force = PVector.sub(location,m.location);
    float distance = force.mag();
    distance = constrain(distance,5.0,25.0);
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  void display() {
    stroke(0);
    fill(20,200);
    ellipse(location.x,location.y,mass*2,mass*2);
  }
}
int height = 1080;
int width = 1980;
Mover[] movers = new Mover[1000];
Attractor a;
void setup() {
  size(1980, 1080);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.2,2),random(width),random(height));
  }
  a = new Attractor();
}
void draw() {
  background(234);
  a.display();
  if (mousePressed) {
    for (int i = 0; i < movers.length; i++) {
      movers[i] = new Mover(random(1,2),random(width),random(height));
    }
  }
  for (int i = 0; i < movers.length; i++) {
    PVector force = a.attract(movers[i]);
    movers[i].applyForce(force);

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
