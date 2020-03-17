import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
//--------------------------------------------------------------------
Box2DProcessing box2d;
//--------------------------------------------------------------------
ArrayList<Cuerpo>cuerpos;
ArrayList<Bola>bolas;
ArrayList<Pelota>pelotas;
ArrayList<Perimetro>perimetros;
//--------------------------------------------------------------------
PImage lol;
//--------------------------------------------------------------------
void setup()
{
  size(900,500);
//--------------------------------------------------------------------  
  lol = loadImage("lol.jpg");
  lol.resize(900,600);
//--------------------------------------------------------------------  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
//--------------------------------------------------------------------  
  cuerpos = new ArrayList<Cuerpo>();
  bolas = new ArrayList<Bola>();
  pelotas = new ArrayList<Pelota>();
  perimetros = new ArrayList<Perimetro>();
//--------------------------------------------------------------------

  perimetros.add(new Perimetro(150,195,400,5,-0.4));
  perimetros.add(new Perimetro(750,195,400,5,0.4));
  
  perimetros.add(new Perimetro(500,200,110,5,-0.6));
  perimetros.add(new Perimetro(410,200,110,5,0.6));
  
  perimetros.add(new Perimetro(505,370.3,80,5,7));
  perimetros.add(new Perimetro(397,370.3,80,5,-7));
  
  perimetros.add(new Perimetro(450,395,50,5,0));
  
//--------------------------------------------------------------------  
  box2d.setGravity(0, -50);
}
//--------------------------------------------------------------------
void draw()
{
   
   background(0);
   
   image(lol,0,0);
   
   box2d.step();
//--------------------------------------------------------------------   
   
  if (keyPressed)
   {
      if(key == 'q')
      {
      Cuerpo p = new Cuerpo(200,110);
      cuerpos.add(p);
      }
//--------------------------------------------------------------------         
      if(key == 'w')
      {
      Bola b = new Bola(700,110);
      bolas.add(b);
      }
//--------------------------------------------------------------------         
      if(key == 'e')
      {
        Pelota b = new Pelota(460,110);
        pelotas.add(b);
      }
   }
//--------------------------------------------------------------------   
    for (Cuerpo b: cuerpos) 
    {
    b.display();
    }
//--------------------------------------------------------------------       
    for (Bola p: bolas)
    {
    p.display();  
    }
//--------------------------------------------------------------------
 for(Pelota b: pelotas)
    {
      b.display();
    }
//--------------------------------------------------------------------
  for (int i = cuerpos.size()-1; i >= 0; i--) 
  {
    Cuerpo b = cuerpos.get(i);
    if (b.done()) {
      cuerpos.remove(i);
    }
  }
//--------------------------------------------------------------------
  for (int i = bolas.size()-1; i >= 0; i--) 
  {
    Bola b = bolas.get(i);
    if (b.done()) {
      bolas.remove(i);
    }
  }
//--------------------------------------------------------------------
 for (int i = pelotas.size()-1; i >= 0; i--) 
  {
    Pelota b = pelotas.get(i);
    if (b.done()) {
      pelotas.remove(i);
    }
  }
//--------------------------------------------------------------------
for(Perimetro wall: perimetros)
   {
    wall.display();
   }
}

//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------Bola--------------------------------------

class Bola
{
  Body body;
  float w;
  float h;
//--------------------------------------------------------------------  
  Bola(float x, float y)
  {
    w = random (0,10);
    h = random (0,10);
    makeBody(new Vec2(x,y),w,h);
    
  }
//--------------------------------------------------------------------  
  void killBody()
  {
    box2d.destroyBody(body);
  }
  
  boolean done()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+w*h)
    {
      killBody();
      return true;
    }
      return false;
  }
//--------------------------------------------------------------------  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    ellipseMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(#FC0011);
    noStroke();
    ellipse(0,0,5,5);
    popMatrix();
  }
//--------------------------------------------------------------------  
  void makeBody(Vec2 center, float w_, float h_)
  {
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(random(-5, 5), random(-30, -5)));
    body.setAngularVelocity(random(-5, -30));

   }
}

//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------Cuerpo------------------------------------

class Cuerpo
{
  
  Body body;
  float w;
  float h;
//--------------------------------------------------------------------  
  Cuerpo(float x, float y)
  {
    w = random (0,10);
    h = random (0,10);
    makeBody(new Vec2(x,y),w,h);
    
  }
//--------------------------------------------------------------------  
  void killBody()
  {
    box2d.destroyBody(body);
  }
  
  boolean done()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+w*h)
    {
      killBody();
      return true;
    }
      return false;
  }
//--------------------------------------------------------------------  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    ellipseMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(#00FC1F);
    noStroke();
    ellipse(0,0,5,5);
    popMatrix();
  }
//--------------------------------------------------------------------  
  void makeBody(Vec2 center, float w_, float h_)
  {
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(random(-5, 5), random(-30, -5)));
    body.setAngularVelocity(random(-5, -30));

   }
}
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------Pelota------------------------------------
class Pelota
{
  Body body;
  float w;
  float h;
//--------------------------------------------------------------------  
  Pelota(float x, float y)
  {
    w = random (0,10);
    h = random (0,10);
    makeBody(new Vec2(x,y),w,h);
    
  }
//--------------------------------------------------------------------  
  void killBody()
  {
    box2d.destroyBody(body);
  }
  
  boolean done()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+w*h)
    {
      killBody();
      return true;
    }
      return false;
  }
//--------------------------------------------------------------------  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    ellipseMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(#C805FF);
    noStroke();
    ellipse(0,0,5,5);
    popMatrix();
  }
//--------------------------------------------------------------------  
  void makeBody(Vec2 center, float w_, float h_)
  {
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(random(-5, 5), random(-30, -5)));
    body.setAngularVelocity(random(-5, -30));

   }
}

//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------Particula---------------------------------
class Particula
{
  Body body;
  float a;
  color col;
//--------------------------------------------------------------------  
  Particula(float x, float y, float a_, boolean fixed)
  {
    a = a_;
    BodyDef bd = new BodyDef();
    if (fixed) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.position = box2d.coordPixelsToWorld(x,y);
    body = box2d.world.createBody(bd);
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(a);
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 2;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    body.createFixture(fd);
    col = color(#08FA9F);
  }
//--------------------------------------------------------------------  
  void killBody()
  {
    box2d.destroyBody(body);
  }
    boolean done() 
     {
     Vec2 pos = box2d.getBodyPixelCoord(body);
     if (pos.y > height+a*2) 
     {
      killBody();
      return true;
     }
      return false;
  }
//--------------------------------------------------------------------  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(#08FA9F);
    stroke(0);
    strokeWeight(1);
    ellipse(0,0,a*2,a*2);
    line(0,0,a,0);
    popMatrix();
  }
}
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------Perimetro---------------------------------
class Perimetro 
{
    float x;
    float y;
    float w;
    float h;
//--------------------------------------------------------------------  
    Body b;
  
    Perimetro(float x_,float y_, float w_, float h_, float a) 
  {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    
    PolygonShape sd = new PolygonShape();
    
    sd.setAsBox(box2dW, box2dH);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
     b.createFixture(sd,1);
  }
//--------------------------------------------------------------------  
  void display() 
  {
    fill(255);
    noStroke();
    strokeWeight(1);
    rectMode(CENTER);
 //--------------------------------------------------------------------    
    float a = b.getAngle();
    pushMatrix();
    translate(x,y);
    rotate(-a);
    rect(0,0,w,h);
    popMatrix();
  }

}
  
//--------------------------------------------------------------------   
//-----------------FIN-DEL-CODIGO-------------------------------------  
//--------------------------------------------------------------------       

  
