//import ddf.minim.*;
//import ddf.minim.analysis.*;
//import ddf.minim.effects.*;
//import ddf.minim.signals.*;
//import ddf.minim.spi.*;
//import ddf.minim.ugens.*;

import java.util.LinkedList;

PShape monde;
PShader myShader;

PVector optimus_Prime;

float camX = width/2.0, camY = height/2.0, camZ = 0;
float posX = 0, posY = 0, posZ = -100;
float ex, ey, ez, vitesse = 0.5;

float alpha = -PI;
float beta = 0;

float zoom = 0;

float distance = 100;

boolean move_forward_W = false, move_forward = false,
  move_backward = false, move_backward_S = false,
  move_left = false, move_right = false,
  move_up = false, move_down = false, show_ligne = true,
  show_pylone = true, show_eol = true, vivaldi = false;

LinkedList<PVector> listPylone;
PVector point_depart;
PVector point_arrive;
float angle_rotation;
float nb_Pylones = 25;

LinkedList<Eolienne> eol;
LinkedList<PShape> lignes_box;

//AudioPlayer player;
float get_z(float x, float y) {
  float result = 0;
  float cx = -250.0;
  float cy = -250.0;
  for (int i=0; i < monde.getChildCount(); i++) {
    PVector center = new PVector(0.0, 0.0, 0.0);
    int nb = monde.getChild(i).getVertexCount();
    for (int j=0; j < nb; j++) {

      center = center.add(monde.getChild(i).getVertex(j));
    }


    if (sqrt((center.x/3-x)*(center.x/3-x) + (center.y/3-y)*(center.y/3-y)) < sqrt((cx-x)*(cx-x) +(cy-y)*(cy-y))) {
      cx = center.x/3;
      cy = center.y/3;
      result = center.z/3;
    }
  }
  return result;
}


void setup() {
  float size = 1;
  int nb_Pylons = 9;
//Minim minim = new Minim(this);
  //player = minim.loadFile("VIVA_VIVALDI.mp3");
  listPylone = new LinkedList<>();
  eol = new LinkedList<>();
  lignes_box = new LinkedList<>();
  size(1200, 1200, P3D);
  monde = loadShape("HYPERSIMPLE/hypersimple.obj");
  float x1=20, y1=100, x2=40, y2=-115;

  //Ajout des positions des pylones
  point_depart = new PVector(x1, y1, get_z(x1, y1));
  point_arrive = new PVector(x2, y2, get_z(x2, y2));
  optimus_Prime = new PVector(x2+4, y2+5.5, get_z(x2+4, y2+5.5)+2.);
  angle_rotation = ((point_arrive.x-point_depart.x)!= 0?
    PI/2+(float)Math.atan((point_arrive.y-point_depart.y)/(point_arrive.x-point_depart.x)):0);

  for (float i=0; i<nb_Pylones*10; i+=10) {
    float x = point_depart.x +i/(nb_Pylones*10)*(point_arrive.x-point_depart.x);
    float y = point_depart.y +i/(nb_Pylones*10)*(point_arrive.y-point_depart.y);
    float z = get_z(x, y);
    listPylone.add(new PVector(x,
      y, z));
  }
  pylone = Create_Pylon(angle_rotation, 1, nb_Pylons);
  pylone.scale(0.3);

  //creation de la ligne des pylones
  Ligne = create_ligne(listPylone, angle_rotation, size, nb_Pylons);
fill(255);
  stroke(255);
  //creation des eoliennes
  eol.add(new Eolienne(50, -100));
  eol.add(new Eolienne(60, -100));
  eol.add(new Eolienne(55, -105));
  eol.add(new Eolienne(50, -105));

  //creation des lignes vers box
  PVector lastPylonecoords=listPylone.getLast();
  lignes_box.add(create_ligne_box(angle_rotation, lastPylonecoords, true, true, optimus_Prime));
  lignes_box.add(create_ligne_box(angle_rotation, lastPylonecoords, false, true, optimus_Prime));
  lignes_box.add(create_ligne_box(angle_rotation, lastPylonecoords, true, false, optimus_Prime));
  lignes_box.add(create_ligne_box(angle_rotation, lastPylonecoords, false, false, optimus_Prime));

  //creation des lignes de box vers les eoliennes
  for (Eolienne eo : eol) {
    lignes_box.add(create_ground_ligne(optimus_Prime, eo));
  }

  frameRate(40);
  //loading des shaders
  myShader = loadShader("myFragmentShader.glsl",
    "myVertexShader.glsl");
}

void draw() {
  fill(0);
  stroke(0);
  background(135,206,235);

  shader(myShader);
  myShader.set("day", frameCount%360);

  if (vivaldi) {
    //player.play();
    background(135*cos((float)frameCount/10), 206*sin((float)frameCount/10), 235*sin((float)frameCount/10));
  } 
  //else player.pause();
  


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
  if (move_forward_W) {
    posY += ey*vitesse*2;
    posX += ex*vitesse*2;
    posZ += ez*vitesse*2;
  }
  if (move_backward) {
    posY -= ey*vitesse;
    posX -= ex*vitesse;
  }
  if (move_backward_S) {
    posY -= ey*vitesse*(3);
    posX -= ex*vitesse*(3);
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

  resetShader();
  if (show_pylone) {
    //Ajout de pylon
    for (PVector c : listPylone) {
      pushMatrix();
      translate(0, 0, c.z);
      shape(pylone, c.x, c.y);
      popMatrix();
    }
    if (show_ligne) {
      shape(Ligne, -2*0.6*cos(angle_rotation), -2*0.6*sin(angle_rotation));
      shape(Ligne, 0, 0);
      pushMatrix();
      translate(0, 0, 0.31);
      shape(Ligne, -2*0.5*cos(angle_rotation), -2*0.5*sin(angle_rotation));
      shape(Ligne, -0.2*cos(angle_rotation), -0.2*sin(angle_rotation));
      popMatrix();
    }
  }


  if (show_eol) {
    pushMatrix();
    fill(0);
    translate(optimus_Prime.x, optimus_Prime.y, optimus_Prime.z);
    stroke(0);
    box(1);
    popMatrix();
    for (PShape ligne : lignes_box) {
      shape(ligne, 0, 0);
    }
    fill(255);
    stroke(255);
    for (Eolienne eo : eol) {
      eo.drawEolienne();
    }

  
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
  if (keyCode == UP) move_forward = true;
  if (keyCode ==  87) move_forward_W = true;
  if (keyCode == DOWN )move_backward = true;
  if (keyCode == 83) move_backward_S = true;
  if (keyCode == LEFT|| keyCode == 'A')move_left = true;
  if (keyCode == RIGHT || keyCode == 68) move_right = true;
  if (keyCode == 17) move_down = true;//ctrl
  if (keyCode == 16) move_up = true;//shift
  if (keyCode == 84) show_pylone = !show_pylone;
  if (keyCode == 89) show_ligne = !show_ligne;
  if (keyCode == 85) show_eol = !show_eol;
  if (keyCode == 86) vivaldi = !vivaldi;

  //zooming  ()
  if (keyCode ==75) {//K
    if (zoom < PI/2) {
      zoom += PI/20;
    }
  }
  if (keyCode == 76) {//L
    if (zoom > PI/20) {
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
  if (keyCode == UP) move_forward = false;
  if (keyCode == 87) move_forward_W = false;
  if (keyCode == DOWN) move_backward = false;
  if (keyCode == 83) move_backward_S = false;
  if (keyCode == LEFT || keyCode == 'A') move_left = false;
  if (keyCode == RIGHT || keyCode == 68) move_right = false;
  if (keyCode == 17)move_down = false;
  if (keyCode == 16)move_up = false;
}
