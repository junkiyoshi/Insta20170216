class Obstacle
{
  Body body;
  float x, y, size;
  color bodyColor;
  
  Obstacle(float x_, float y_)
  {
    x = x_;
    y = y_;
    size = 200;
    bodyColor = color(64);
    makeBody(new Vec2(x, y));
  }
  
  void makeBody(Vec2 center) 
  {
    CircleShape cs = new CircleShape();
    float box2dSize = box2d.scalarPixelsToWorld(size / 2);
    cs.setRadius(box2dSize);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(cs, 1);
    body.setUserData(this);
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);

    pushMatrix();
    translate(pos.x, pos.y);
    fill(bodyColor);
    noStroke();
    h.ellipse(0, 0, size, size);
    popMatrix();
    
  }
  
  void changeColor(color c)
  { 
    bodyColor = c;
  }
}