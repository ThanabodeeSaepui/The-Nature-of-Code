class Polygon {
  Body body;
  Polygon(float x, float y){
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    
    bd.position = box2d.coordPixelsToWorld(x,y);
    body = box2d.world.createBody(bd);
    
    Vec2[] vertices = new Vec2[4];  // An array of 4 vectors
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-15, 25));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(15, 0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(20, -15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-10, -10));
    PolygonShape ps = new PolygonShape();
    ps.set(vertices, vertices.length);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    body.createFixture(fd);
  }
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    beginShape();
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x,v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}
