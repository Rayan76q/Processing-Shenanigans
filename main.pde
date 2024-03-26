PShape monde;
PShader fragmentShader;

float camX = width/2.0;
float camY = height/2.0;
float camZ = 0;

float posX = 0;
float posY = 0;
float posZ = -100;

float dx;
float dy;
float dz;

float alpha = -PI;
float beta = 0;

float anime = 0.0;
float anime_total = 10.0;
float zoom = 0;
float anime_duration = 10.0;

float angleX, angleY;
float distance = 100;

boolean move_forward = false;

void setup(){
  size(1200, 1200 , P3D);
  frameRate(40);
  monde = loadShape("HYPERSIMPLE/hypersimple.obj");
 
  
  angleX = 0; 
  angleY = 0; 
}

void draw(){
  if(anime >0) anime-= 1.0;
  else if (anime ==0) anime_total =anime_duration;
  background(128,128,128);
  shape(monde,0,0);
  

  camX = distance *sin(alpha)*cos(beta) ;
  camY = distance* sin(alpha)*sin(beta);
  camZ = distance * cos(alpha);
  dx = camX/20;
  dy = camY/20;
  dz = camZ/20;
  
  
  camera(posX-dx*anime/anime_total,posY-dy*anime/anime_total,posZ-dz*anime/anime_total,posX + camX,posY + camY, posZ + camZ, 0, 0,-1);
  perspective(PI/2 - sin(anime/10.0*PI)/15 + zoom, width/height, 0.01, 500);
  
  if(move_forward){
    anime += anime_duration; 
    anime_total += anime_duration;
    posX += dx*0.2;
    posY += dy*0.2;
    posZ += dz*0.2;
  }
  translate(width/2, height/2, 0);

  
}
void mouseDragged() {
  float db = (float)(mouseX - pmouseX) / width * TWO_PI;
  float dalpha = (float)(-mouseY + pmouseY) / height * PI;
  if(abs(alpha+dalpha) <PI-0.02 && alpha+dalpha <0){
    alpha += dalpha;
  }
  beta += db;
}

void keyPressed(){
  if(keyCode == UP || keyCode==  87){
    move_forward = true; 
  }
  if(keyCode == DOWN){
    anime = anime_duration; 
    posX -= dx;
    posY -= dy;
    posZ -= dz;
    
    
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

void keyReleased(){
  if(keyCode == UP || keyCode == 87) move_forward = false;
}
