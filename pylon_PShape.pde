PShape pylon_block[];
int nb_Pylons=9;
PShape cone;
int size = 20;
float coneSize = 5*size*pow(0.9,nb_Pylons);
//void setup() {
//  size(400, 400, P3D);
//  cone = myCone(coneSize,200);
//  createPylonBlocss(size);
//}

PShape myCone(float sideSize, int nbSide){
  PShape shape0 = createShape();
  shape0.beginShape(TRIANGLE_FAN);
  shape0.fill(128);
  shape0.noStroke();
  shape0.vertex(0,0,0);
  for (int i=0; i<=nbSide; i++){
    shape0.vertex(sideSize/4*cos(i*2*PI/nbSide),
                  sideSize/4*sin(i*2*PI/nbSide),
                  sideSize);
  }
  shape0.endShape();
  return shape0;
}

void createPylonBlocss(float size){
  pylon_block = new PShape[nb_Pylons];
  // Define the pylon_block
  pylon_block[0] = createShape();
  pylon_block[0].beginShape(LINES);
  pylon_block[0].stroke(0, 0, 0); // Set color to black
  pylon_block[0].strokeWeight(0.5);
  createPylonBlock(size,pylon_block[0]);
  pylon_block[0].endShape();
  int translation_rate = 0;
  for(int i = 1; i<nb_Pylons;i++){
    translation_rate+= 2*size*pow(0.9,i);
    pylon_block[i] = createShape();
    pylon_block[i].beginShape(LINES);
    pylon_block[i].stroke(0, 0, 0); // Set color to black
    pylon_block[i].strokeWeight(0.5);
    pylon_block[i].translate(0,0,translation_rate);
    createPylonBlock(size*pow(0.9,i),pylon_block[i]);
    pylon_block[i].endShape();
  }
}

void createPylonBlock(float size, PShape pylon_block){
    //up and down
    pylon_block.vertex(-size, -size, -size);
    pylon_block.vertex(size, size, -size);
    pylon_block.vertex(size, -size, -size);
    pylon_block.vertex(-size, size, -size);
    
    pylon_block.vertex(-size*0.9, -size*0.9, size*0.9);
    pylon_block.vertex(size*0.9, size*0.9, size*0.9);
    pylon_block.vertex(size*0.9, -size*0.9, size*0.9);
    pylon_block.vertex(-size*0.9, size*0.9, size*0.9);
    
    //front and back
    
    pylon_block.vertex(-size,-size,-size);
    pylon_block.vertex(size*0.9,-size*0.9,size*0.9);
    pylon_block.vertex(-size*0.9,-size*0.9,size*0.9);
    pylon_block.vertex(size,-size,-size);
    
    pylon_block.vertex(-size,size,-size);
    pylon_block.vertex(size*0.9,size*0.9,size*0.9);
    pylon_block.vertex(-size*0.9,size*0.9,size*0.9);
    pylon_block.vertex(size,size,-size);
    
    //sides
    
    pylon_block.vertex(-size, -size, -size);
    pylon_block.vertex(-size*0.9, size*0.9, size*0.9);
    pylon_block.vertex(-size*0.9, -size*0.9, size*0.9);
    pylon_block.vertex(-size, size, -size);
    
    pylon_block.vertex(size, -size, -size);
    pylon_block.vertex(size*0.9, size*0.9, size*0.9);
    pylon_block.vertex(size*0.9, -size*0.9, size*0.9);
    pylon_block.vertex(size, size, -size);
        
    //verticales and horizontals
    
    //x
    pylon_block.vertex(-size,-size,-size);
    pylon_block.vertex(size,-size,-size);
    
    pylon_block.vertex(-size*0.9,-size*0.9,0.9*size);
    pylon_block.vertex(size*0.9,-size*0.9,size*0.9);
    
    pylon_block.vertex(-size,size,-size);
    pylon_block.vertex(size,size,-size);
    
    pylon_block.vertex(-size*0.9,size*0.9,size*0.9);
    pylon_block.vertex(size*0.9,size*0.9,size*0.9);
    
    //y
    pylon_block.vertex(-size,-size,-size);
    pylon_block.vertex(-size,size,-size);
    
    pylon_block.vertex(-size*0.9,-size*0.9,size*0.9);
    pylon_block.vertex(-size*0.9,size*0.9,size*0.9);
    
    pylon_block.vertex(size,-size,-size);
    pylon_block.vertex(size,size,-size);
    
    pylon_block.vertex(size*0.9,-size*0.9,size*0.9);
    pylon_block.vertex(size*0.9,size*0.9,size*0.9);
    
    //z
    pylon_block.vertex(-size,-size,-size);
    pylon_block.vertex(-size*0.9,-size*0.9,size*0.9);
    
    pylon_block.vertex(-size,size,-size);
    pylon_block.vertex(-size*0.9,size*0.9,size*0.9);
    
    pylon_block.vertex(size,-size,-size);
    pylon_block.vertex(size*0.9,-size*0.9,size*0.9);
    
    pylon_block.vertex(size,size,-size);
    pylon_block.vertex(size*0.9,size*0.9,size*0.9);
}

void draw_Pylon(float x, float y, float z){
  pushMatrix();
  translate(x,y,z);
  for(int i=0;i <nb_Pylons;i++){
    shape(pylon_block[i]);
  }
  popMatrix();
  pushMatrix();
  translate(coneSize+size*pow(0.9,nb_Pylons),0,size*nb_Pylons);
  rotateY(-PI/2);
  shape(cone);
  popMatrix();
  pushMatrix();
  translate(-coneSize-size*pow(0.9,nb_Pylons),0,size*nb_Pylons);
  rotateY(PI/2);
  shape(cone);
  popMatrix();
}

//void draw() {
//  background(255);
//  lights();
//  translate(width/2, height/2);
//  rotateX(PI/3);
//  //rotateZ(frameCount * 0.01);
//  //rotateY(frameCount * 0.01);
//  //shape(cube);
//  //rotateY(mouseY);
//  draw_Pylon(0,0,0);
//  //rotateX(PI/3.0);
//  //translate(
//}
