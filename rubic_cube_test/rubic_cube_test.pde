import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;
AudioPlayer pl_1;
BeatDetect beat;

float size = 0;
float speed = 0;

ArrayList<Cube> cubes = new ArrayList<Cube>();

float shapeDis = 12;
float shapeNum = 8;
float rotSpeed = 1.5;
float scaleNumL = 0;
float scaleNumG = 0;
float fade = 20;

int colorR = 250;
int colorG = 20;
int colorB = 20;

float count = 0;

boolean keyDown = false;

PShader cubeClr;
PImage img;

void setup()
{
  size(800, 800, P3D);
  rectMode(CENTER);
  noStroke();


  img = loadImage("clr.png");

  minim = new Minim(this);
  beat = new BeatDetect();

  beat.detectMode(BeatDetect.FREQ_ENERGY);


  makeCubes();
  /*
  for (int i = 0; i < shapeNum; i++)
   {
   for (int j = 0; j < shapeNum; j++)
   {
   
   
   
   for (int l = 0; l < shapeNum; l++)
   {
   //cubes.add(new Cube(i * shapeDis, j * shapeDis));
   cubes.add(new Cube(i * shapeDis, j * shapeDis, l * shapeDis));
   
   }
   
   //shapeNum++;
   }
   }
   */

  String name = "beat.mp3";

  pl_1 = minim.loadFile(name);

  pl_1.loop();
}

void draw()
{
  //makeCubes();



  //shapeDis++;
  lights();
  fill(0, 0, 0, fade);
  rect(width/2, height/2, width, height);
  fill(colorR, colorG, colorB);

  beat.detect(pl_1.mix);

  if (beat.isKick()) // isHat, isSnare
  {
    if (scaleNumL < 2.3)
    {
      scaleNumL += .4;
    }
  }

  if (beat.isSnare()) // isHat, isSnare
  {

    if (scaleNumG < 2.3)
    {
      scaleNumG += .4;
    }
  }

  if (beat.isSnare()) // isHat, isSnare
  {

    if (shapeDis < 16)
    {
      //shapeDis += 8;
    }
  }


  float time = millis()/1000.0; // get number of seconds as a float
  float scale =  (7 + 5 * sin(time)); // two methods for setting scale
  float angle = time * rotSpeed; // two methods for setting angle

  background(123);

  pushMatrix();

  //

  translate(400, 400); // reposition in center of window
  rotateX(angle / 2); // rotate
  rotateY(angle / 2); // rotate
  rotateZ(-angle / 2); // rotate
  scale(3 - (scaleNumG / 1), 3 - (scaleNumG / 1), 3 - (scaleNumG / 1));
  translate(((-shapeDis * shapeNum) / (2)) + (shapeDis / 2), ((-shapeDis * shapeNum) / (2) + (shapeDis / 2)), ((-shapeDis * shapeNum) / (2) + (shapeDis / 2))); // slide up and to the left

  //translate(((-(shapeDis + count) * shapeNum) / (2)) + ((shapeDis + count) / 2), ((-(shapeDis + count) * shapeNum) / (2)) + ((shapeDis + count) / 2));
  //translate(-20, -20);
  for (Cube c : cubes)
  {

    c.update(scaleNumL, scaleNumG, img);
  }

  popMatrix();

  scaleNumL *= .9;
  scaleNumG *= .8;

  if (shapeDis > 12)
  {
    shapeDis -= .25;
  }
  //count += 2;

  fill(0);
  text("music Forever be by Richard Day on Dewolfe", 20, 20);


  //removeCubes();
}


void makeCubes()
{


  for (int i = 0; i < shapeNum; i++)
  {
    for (int j = 0; j < shapeNum; j++)
    {

      for (int l = 0; l < shapeNum; l++)
      {
        //cubes.add(new Cube(i * shapeDis, j * shapeDis));

        //if (i != 0 && j != 0 && l !=  0)
        //{
          cubes.add(new Cube(i * shapeDis, j * shapeDis, l * shapeDis));
        //}
      }

      //shapeNum++;
    }
  }
}

void removeCubes()
{

  for (int i = cubes.size () - 1; i >= 0; i--)
  {
    cubes.remove(i);
  }
}

// auomatically calld upon closing the program
void stop()
{
  pl_1.close();
  minim.stop();
}

void keyPressed()
{


  if (key == CODED && !keyDown)
  {
    if (keyCode == UP)
    {
      shapeNum++;

      removeCubes();
      makeCubes();
    }

    if (keyCode == DOWN)
    {
      shapeNum--;

      removeCubes();
      makeCubes();
    }

    if (keyCode == LEFT)
    {
      rotSpeed -= .5;
    }

    if (keyCode == RIGHT)
    {
      rotSpeed += .5;
    }
  }

  keyDown = true;
}

void keyReleased()
{
  keyDown = false;
}

