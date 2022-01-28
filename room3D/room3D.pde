//note: my computer wouldnt let me do the mouse loop thing 
//because i needed the admin password but i couldnt get it so thats why its not there

import java.awt.Robot;

Robot rbt;

//textures 
PImage mossStone, block;


color black = #000000;
color blue = #7092BE;
color white = #FFFFFF;

int gridSize;
PImage map;

boolean wkey, dkey, skey, akey;
boolean skipframe;
float eyex, eyey, eyez, focusx, focusy, focusz, tiltx, tilty, tiltz;
float leftRightHeadAngle, upDownHeadAngle;

void setup() {
  size(displayWidth, displayHeight, P3D);
  textureMode(NORMAL);
  wkey = akey = skey = dkey = false;

  eyex = width/2;
  eyey = 9*height/12;
  eyez = height/2;

  focusx = width/2;
  focusy = height/2;
  focusz = 10;

  tiltx = 0;
  tilty = 1;
  tiltz = 0;

  //map
  map = loadImage("map.png");
  gridSize = 100;

  //textures
  mossStone = loadImage("mossStone.png");
  block = loadImage("block.png");

  skipframe = false;

  leftRightHeadAngle = radians(270);
  noCursor();
  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}


void draw() {
  background(0);
  camera(eyex, eyey, eyez, focusx, focusy, focusz, tiltx, tilty, tiltz);
  drawFloor();
  drawCeiling();
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawFloor() {
  stroke(255);

  for (int x = -2000; x <= 2000; x = x + 100) {
    //line(x, height, -2000, x, height, 2000);
    //line (-2000, height, x, 2000, height, x);
    texturedCube(x, height, -200, block, gridSize);
  }
}

void drawCeiling() {
  stroke(255);

  for (int x = -2000; x <= 2000; x = x + 100) {
    //line(x, height-gridSize*3, -2000, x, height-gridSize*3, 2000);
    //line (-2000, height-gridSize*3, x, 2000, height-gridSize*3, x);
     texturedCube(x, height-gridSize*4, -200, block, gridSize);
  }
}

void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get (x, y);
      if (c == blue) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, mossStone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, mossStone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, mossStone, gridSize);
      }
      if (c == black) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, block, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, block, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, block, gridSize);
      }
      if (c == white) {
      }
    }
  }
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusx, focusy, focusz);
  sphere(5);
  popMatrix();
}
void controlCamera() {

  if (wkey) {
    eyex = eyex + cos(leftRightHeadAngle) * 10;
    eyez = eyez + sin(leftRightHeadAngle)*10;
  }

  if (skey) {
    eyex = eyex - cos(leftRightHeadAngle) * 10;
    eyez = eyez - sin(leftRightHeadAngle)*10;
  }
  if (akey) {
    eyex = eyex - cos(leftRightHeadAngle + PI/2) * 10;
    eyez = eyez - sin(leftRightHeadAngle + PI/2)*10;
  }
  if (dkey) {
    eyex = eyex - cos(leftRightHeadAngle - PI/2) * 10;
    eyez = eyez - sin(leftRightHeadAngle - PI/2)*10;
  }

  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)* 0.01;
  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle < - PI/2.5) upDownHeadAngle = -PI/2.5;


  focusx = eyex + cos(leftRightHeadAngle) * 300;
  focusz = eyez + sin(leftRightHeadAngle)*300;

  focusy = eyey + tan(upDownHeadAngle) * 300;

  if (mouseX > width-2) rbt.mouseMove(3, mouseY);
  else  if (mouseX < 2) rbt.mouseMove(width-3, mouseY);
}
void keyPressed() {

  if (key == 'W' || key == 'w') wkey = true;
  if (key == 'D' || key == 'd') dkey = true;
  if (key == 'S' || key == 's') skey = true;
  if (key == 'A' || key == 'a') akey = true;
}

void keyReleased() {
  if (key == 'W' || key == 'w') wkey = false;
  if (key == 'D' || key == 'd') dkey = false;
  if (key == 'S' || key == 's') skey = false;
  if (key == 'A' || key == 'a') akey = false;
}
