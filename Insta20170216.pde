import org.gicentre.handy.*;
import java.util.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Particle> particles;
Box box;
HandyRenderer h;
Obstacle[] obstacles;

void setup()
{
  size(1080, 1080);
  frameRate(30);
  colorMode(HSB);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -15);
  box2d.listenForCollisions();
  
  box = new Box();
  h = HandyPresets.createMarker(this);
  h.setRoughness(1);
  
  particles = new ArrayList<Particle>();
  obstacles = new Obstacle[3];
  obstacles[0] = new Obstacle(width / 2, height / 2);
  obstacles[1] = new Obstacle(width / 6 * 1, height / 6 * 4);
  obstacles[2] = new Obstacle(width / 6 * 5, height / 6 * 4);
}

void draw()
{
  box2d.step();
  background(255);
  
  for(Obstacle obs : obstacles)
  {
    obs.display();
  }
  
  if(frameCount % 30 == 1)
  {
    Particle p = new Particle(random(width * 0.2, width * 0.8), 50, 50, color(random(255), 255, 255));
    particles.add(p);
  }  
  
  Iterator<Particle> it = particles.iterator();
  while(it.hasNext())
  {
    Particle p = it.next();
    p.display();
    
    if(p.isDead())
    {
      it.remove();
    }
  }
  
  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 1800)
  {
     exit();
  }
  */
}

void beginContact(Contact cp)
{
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if(o1.getClass() == Particle.class)
  {
    Particle p = (Particle)o1;
    p.lifespan -= 30;
  }
  
  if(o2.getClass() == Particle.class)
  {
    Particle p = (Particle)o2;
    p.lifespan -= 30;
  }
  
  if(o1.getClass() == Obstacle.class)
  {
    Obstacle o = (Obstacle)o1;
    Particle p = (Particle)o2;
    o.changeColor(p.bodyColor);
    return;
  }
  else if(o2.getClass() == Obstacle.class)
  {
    Obstacle o = (Obstacle)o2;
    Particle p = (Particle)o1;
    o.changeColor(p.bodyColor);
    return;
  }
  
  
}