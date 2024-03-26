PShape monde;
PShader fragmentShader;

float camX = width/2.0;
float camY = height/2.0;
float camZ = 0;

float posX = 0;
float posY = 0;
float posZ = -100;

float alpha = -PI;
float beta = 0;

float anime = 0;
float zoom = 0;



float angleX, angleY;
float distance = 500;

void setup(){
  size(1200, 1200 , P3D);
  frameRate(40);
  monde = loadShape("HYPERSIMPLE/hypersimple.obj");
 
  
  angleX = 0; // Initial rotation angle around X-axis
  angleY = 0; // Initial rotation angle around Y-axis
}

void draw(){
  background(128,128,128);
 shape(monde,0,0);
  

  camX = 100 *sin(alpha)*cos(beta) ;
  camY = 100* sin(alpha)*sin(beta);
  camZ = 100 * cos(alpha);
  

  

  perspective(PI/1.5 - sin(anime/10.0*PI)/15 + zoom, width/height, 0.01, 500);
  camera(posX,posY,posZ,posX + camX,posY + camY, posZ + camZ, 0, 0,-1);

  translate(width/2, height/2, 0);

  
}
void mouseDragged() {
  float db = (float)(mouseX - pmouseX) / width * TWO_PI;
  float dalpha = (float)(mouseY - pmouseY) / height * PI; 
  beta += db;
  alpha += dalpha;
}

void keyPressed(){
  if(keyCode == UP){
    anime = 20; 
  }
  else if(keyCode == LEFT){
    zoom -= PI/20;
  }
  else  if(keyCode == RIGHT){
    zoom += PI/20;
  }
  else  if(keyCode == ' '){
      camX = width/2.0;
      camY = height/2.0;
      camZ = 0;

      posX = 0;
      posY = 0;
      posZ = -100;
  }
}
