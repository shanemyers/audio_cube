class Cube
{
  
  PShape obj;
  
  float x = 0;
  float y = 0;
  float z = 0;
  
  float count = 0;
  float clrNum = 0;
  
  int type = 0;
  
  public Cube()
  {
  }
  
  public Cube(float x, float y)
  {
    
    //2d
    
    type = 0;
    
    this.x = x;
    this.y = y;
  }
  
  public Cube(float x, float y, float z)
  {
    
    obj = loadShape("cube.obj");
    
    type = 1;
    
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public void update(float scaleNumL, float scaleNumG, PImage img)
  {
    clrNum = (scaleNumG * 4);
    
    pushMatrix();
    
    if(type == 0)
    {
      rect(this.x + count, this.y + count, 10 * scaleNumL + 10, 10 * scaleNumL + 10);
    }
    

    if(type == 1)
    {
      //tint(255, 0,0);
      translate(this.x, this.y, this.z);
      
      beginShape();
      
      
      //texture(img);
      //shape(obj, 0, 0, 10, 10);
      fill(clrNum * 50, 0, 30, 50);
      
      strokeWeight(8);
      stroke(60, 0,0 , 60);
      
      //tint(255, 0, 0);
      box(10 - clrNum * 2);
      endShape();
    }
    
    // Draw
    //shape(obj, 0, 0);
    
    
    
    //translate(-15, -15); // slide up and to the left
  //scale(2, 2); // scale up
  //rotate(PI/8); // rotate
  //translate(400, 400); // reposition in center of window
    
    
    
    popMatrix();
    
    clrNum *= .99;

  }
  
}
