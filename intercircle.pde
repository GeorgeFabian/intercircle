ArrayList<Stylus> styli, stylo;

void setup() 
{
  size(1000, 720);
  styli = new ArrayList<Stylus>();
  stylo = new ArrayList<Stylus>();
  for(int i = 1; i < 250; i++)
  {
    Stylus stylos = new Stylus(width/2, height/2, i*2.5);
    styli.add(stylos);
  }
  //Collections.shuffle(styli);
  
  background(255);
  smooth();
  noStroke();
  noCursor();
}

void draw()
{
  //if (styli.size() > 0 && frameCount % 10 == 0) stylo.add(styli.remove(0));
  for (Stylus s : styli)
  {
    s.update();
  }
}

class Stylus
{
  float x, y, rad, iter, end, noi, se;
  PVector pos;
  boolean ccw;
  
  public Stylus(float x, float y, float rad)
  {
    this.x = x;
    this.y = y;
    this.rad = rad;
    pos = new PVector(x, y);
    iter = random(0, radians(360));
    //iter = 0;
    noi = .04;// - (rad/30000);
    se = .002;
    if(random(-1, 1) > 0) 
    {
      ccw = true;
      end = iter - radians(360);
    }
    else 
    {
      ccw = false;
      end = iter + radians(360);
    }
  }
  
  public void update()
  {
    if ((!ccw && iter <= end) || (ccw && iter >= end))
    {
      pos.x = cos(iter) * rad + x;
      pos.x += (noise((pos.x)*noi, (pos.y)*noi)-.5)*(10) + (noise((pos.x+width)*noi, (pos.y+height)*noi)-.5)*(10);
      pos.x += (noise((pos.x)*se, (pos.y)*se)-.5)*70;
      pos.y = sin(iter) * rad + y;
      pos.y += (noise((pos.x)*noi, (pos.y)*noi)-.5)*(10) + (noise((pos.x+width)*noi, (pos.y+height)*noi)-.5)*(10);
      pos.y += (noise((pos.x)*se, (pos.y)*se)-.5)*70;
      
      PVector newPos = new PVector(0, 0);
      float iterStep = 0;

      pos.add(newPos);
      
      if (ccw) iter -= .5/(rad);
      else iter += .5/(rad);
      
      fill(0, 10+rad/30, 20+rad/15);
      ellipse(pos.x, pos.y, 1+rad/3500, 1+rad/3500); 
    }
  }
}
