class MultiShape {
  float h = 20;
  float w = 8;
  float r;
  Body body;
  MultiShape(float r,float x, float y) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    Vec2 center = new Vec2(x,y);
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);
    // Our offset in pixels
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    Vec2 offset = new Vec2(0,-h/2);
    // Converting the vector to Box2D world
    offset = box2d.vectorPixelsToWorld(offset);
    // Setting the local position of the circle
    cs.m_p.set(offset.x,offset.y);
    
    body.createFixture(ps,1.0);
    body.createFixture(cs,1.0);
  }
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rect(0,0,w,h);
    ellipse(0,-h/2,r*2,r*2);
    popMatrix();
  }
}
