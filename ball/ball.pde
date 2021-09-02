class PVector {
  float x;
  float y;
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
}
PVector location = new PVector(150,160);
PVector velocity = new PVector(2,3);
int size = 80;
void setup() {
  size(640, 360); // x,y
}
void draw() {
  background(204);
  ellipse(location.x,location.y, size,size);
  move();
}
void move() {
  if (location.x+(size/2) >= 640 || location.x-(size/2) <= 0) {
    velocity.x = velocity.x * -1;
  }
  if (location.y+(size/2) >= 360 || location.y-(size/2) <= 0){
    velocity.y = velocity.y * -1;
  }
  location.add(velocity);
}
