PShape monde;
PImage texture;
PShader shader;
float px,py,pz,dx=1,dy=0,dz=0;
int anim= 0, rotate;
float xmin = -135, xmax = 127, ymin = -158, 
  ymax= 159, zmin = -202.09592, zmax = -179.59933;

void setup(){
  size(1200, 1200 , P3D);
  frameRate(40);
  monde = createShape();
  monde = loadShape("HYPERSIMPLE/hypersimple.obj");
  px =0;
  py = 0;
  pz = zmax;
}

void advance_cam(){
  camera(px-dx*anim/20,py-dy*anim/20,pz-dz*anim/20, px,py,pz,0,0,-1);
}

void draw(){
  background(200,200,200);
  shape(monde , 0,0);
  translate(-(abs(xmin)+abs(xmax))/2,-(abs(ymax)+abs(ymin))/2,zmax);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(PI/3.,width*1.2/height, 0.5, 10*cameraZ);
  if (anim >0) {
    advance_cam();
    anim--;
  }
}

void keyPressed() {
  if (anim == 0 && rotate==0){
    if (keyCode == UP) {
      anim = 20;
      px += dx*10;
      py += dy*10;
      pz += dz*10;
    }
  }
}
