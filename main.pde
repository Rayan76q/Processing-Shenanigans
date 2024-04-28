import java.util.LinkedList;
PShape monde;
PShader myShader;

float camX = width/2.0, camY = height/2.0, camZ = 0;
float posX = 0, posY = 0, posZ = -100;
float ex, ey, ez, vitesse = 0.5;

float alpha = -PI;
float beta = 0;

float zoom = 0;

float distance = 100;

boolean move_forward_W = false, move_forward = false, 
    move_backward = false ,move_backward_S = false,
    move_left = false , move_right = false , 
    move_up = false , move_down = false;

LinkedList<PVector> listPylone;
PVector point_depart;
PVector point_arrive;
float nb_Pylones = 15;

float get_z(float x , float y){
  float result = 0;
  float cx = -250.0;
  float cy = -250.0;
  for(int i=0 ; i < monde.getChildCount();i++){
    PVector center = new PVector(0.0,0.0,0.0);
    int nb = monde.getChild(i).getVertexCount();
    for(int j=0 ; j < nb;j++){
      
      center = center.add(monde.getChild(i).getVertex(j));
    }

    
    if(sqrt((center.x/3-x)*(center.x/3-x) + (center.y/3-y)*(center.y/3-y)) < sqrt((cx-x)*(cx-x) +(cy-y)*(cy-y))){
        cx = center.x/3;
        cy = center.y/3;
        result = center.z/3;
    }
  }
  return result;
}


void setup(){
  listPylone = new LinkedList<>();
  size(1200, 1200 , P3D);
  monde = loadShape("HYPERSIMPLE/hypersimple.obj");
  //Ajout des positions des pylones 
  point_depart = new PVector(-100,50,get_z(-100,50));
  point_arrive = new PVector(50,50,get_z(50,50));
  float angle_rotation = ((point_arrive.x-point_depart.x)!= 0?
  PI/2-(float)Math.atan((point_arrive.y-point_depart.y)/(point_arrive.x-point_depart.x)):0);
  
  for(float i=0 ; i<nb_Pylones*10; i+=10){
    float x = point_depart.x +i/(nb_Pylones*10)*(point_arrive.x-point_depart.x);
    float y = point_depart.y +i/(nb_Pylones*10)*(point_arrive.y-point_depart.y);
    float z = get_z(x,y);
    listPylone.add(new PVector(x,
    y,z));
  }
  createPylonBlocss(size);
  pylone = Create_Pylon(angle_rotation);
  pylone.scale(0.3);
  frameRate(40);
  myShader = loadShader("myFragmentShader.glsl",
    "myVertexShader.glsl");

  Ligne = create_ligne(listPylone,angle_rotation);
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
  if (move_forward_W){
    posY += ey*vitesse*2;
    posX += ex*vitesse*2;
    posZ += ez*vitesse*2;
  }
  if(move_backward){
    posY -= ey*vitesse;
    posX -= ex*vitesse;
  }
  if(move_backward_S){
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
  
  //Ajout de pylon 
  for(PVector c : listPylone){
    pushMatrix();
    //listPylone.add(new Pylone_coords(i,50,z));
    translate(0,0,c.z);
    shape(pylone,c.x,c.y);
    popMatrix();
  }
  
  shape(Ligne,0,0);
  
  Eolienne e = new Eolienne(20,10);
  e.drawEolienne();
  
}
void mouseDragged() {
  float db = (float)(mouseX - pmouseX) / width * TWO_PI;
  float dalpha = (float)(-mouseY + pmouseY) / height * PI;
  if (abs(alpha+dalpha) <PI-0.02 && alpha+dalpha <0) {
    alpha += dalpha;
  }
  beta += db;
}

void keyPressed(){
  if(keyCode == UP) move_forward = true;
  if (keyCode ==  87) move_forward_W = true; 
  if(keyCode == DOWN )move_backward = true;
  if(keyCode == 83) move_backward_S = true;
  if(keyCode == LEFT|| keyCode == 'A')move_left = true;
  if(keyCode == RIGHT || keyCode == 68) move_right = true;
  if(keyCode == 17) move_down = true;//ctrl
  if(keyCode == 16) move_up =true;//shift
  
  //zooming  ()
  if(keyCode ==75){//K
    if(zoom < PI/2){
      zoom += PI/20;
    }
  }
  if(keyCode == 76){//L
    if(zoom > PI/20){
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

void keyReleased(){
  if(keyCode == UP) move_forward = false;
  if (keyCode == 87) move_forward_W = false;
  if(keyCode == DOWN) move_backward = false;
  if(keyCode == 83) move_backward_S = false;
  if(keyCode == LEFT || keyCode == 'A') move_left = false;
  if(keyCode == RIGHT || keyCode == 68) move_right = false;
  if(keyCode == 17)move_down = false;
  if(keyCode == 16)move_up = false;
}
