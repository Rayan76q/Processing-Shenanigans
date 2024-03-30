PShape monde;
PShader myShader;

float camX = width/2.0, camY = height/2.0, camZ = 0;
float posX = 0, posY = 0, posZ = -100;
float ex, ey, ez, vitesse = 2;

float alpha = -PI;
float beta = 0;

float zoom = 0;

float angleX, angleY;
float distance = 100;

boolean move_forward = false, move_left = false, move_right = false, move_backward = false, move_up = false, move_down = false;

void setup() {
  size(1200, 1200, P3D);
  frameRate(40);
  monde = loadShape("HYPERSIMPLE/hypersimple.obj");
  myShader = loadShader("myFragmentShader.glsl",
    "myVertexShader.glsl");

  angleX = 0;
  angleY = 0;
}

void draw() {
  shader(myShader);

  background(128, 128, 128);
  shape(monde, 0, 0);

  ex = sin(alpha)*cos(beta);
  ey =  sin(alpha)*sin(beta);
  ez = cos(alpha);

  camX = distance *ex ;
  camY = distance* ey;
  camZ = distance * ez;



  camera(posX, posY, posZ, posX + camX, posY + camY, posZ + camZ, 0, 0, -1);

  perspective(PI/2 + zoom, width/height, 0.01, 500);

  if (move_forward) {
    posY += ey*vitesse;
    posX += ex*vitesse;
  }
  if (move_backward) {
    posY -= ey*vitesse;
    posX -= ex*vitesse;
  }
  if (move_left) {
    posX += ey*vitesse;
    posY += -ex*vitesse;
  }
  if (move_right) {
    posX -= ey*vitesse;
    posY -= -ex*vitesse;
  }
  if (move_up) {
    posZ +=vitesse;
  }
  if (move_down) {
    posZ -=vitesse;
  }
}
void mouseDragged() {
  float db = (float)(mouseX - pmouseX) / width * TWO_PI;
  float dalpha = (float)(-mouseY + pmouseY) / height * PI;
  if (abs(alpha+dalpha) <PI-0.02 && alpha+dalpha <0) {
    alpha += dalpha;
  }
  beta += db;
}

void keyPressed() {
  if (keyCode == UP || keyCode ==  87) move_forward = true;
  if (keyCode == DOWN || keyCode == 83) move_backward = true;
  if (keyCode == LEFT|| keyCode == 81)move_left = true;
  if (keyCode == RIGHT || keyCode == 68) move_right = true;
  if (keyCode == 17) move_down = true;//ctrl
  if (keyCode == 16) move_up =true;//shift

  //zooming
  if (keyCode ==75) {//K
    if (zoom < PI/5) {
      zoom += PI/20;
    }
  }
  if (keyCode == 76) {//L
    if (zoom > - 2*PI/5) {
      zoom -= PI/20;
    }
  }


  if (keyCode == ' ') {
    camX = width/2.0;
    camY = height/2.0;
    camZ = 0;

    posX = 0;
    posY = 0;
    posZ = -100;
  }
}

void keyReleased() {
  if (keyCode == UP || keyCode == 87) move_forward = false;
  if (keyCode == DOWN || keyCode == 83) move_backward = false;
  if (keyCode == LEFT || keyCode == 81) move_left = false;
  if (keyCode == RIGHT || keyCode == 68) move_right = false;
  if (keyCode == 17)move_down = false;
  if (keyCode == 16)move_up = false;
}
