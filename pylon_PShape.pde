//static final int nb_Pylons=9;
PShape pylone;

//void setup() {
// size(400, 400, P3D);
//  createPylonBlocss(size);
//  pylone = Create_Pylon();
//}

PShape myCone(float sideSize, int nbSide, float x, float y, float z,float w, int dir) {
  //dir :
  // dir = 1 <=> left
  // dir = 0 <=> right
  // dir = 2 <=> up
  PShape shape0 = createShape();
  shape0.beginShape(TRIANGLE_FAN);
  shape0.fill(0);
  shape0.noStroke();
  shape0.vertex(x, y, z);
  if (dir ==1) {
    for (int i=0; i<=nbSide; i++) {
      shape0.vertex(x+sideSize,
        y+sideSize/w*sin(i*2*PI/nbSide),
        z+sideSize/w*cos(i*2*PI/nbSide));
    }
  } else if (dir == 0) {
    for (int i=0; i<=nbSide; i++) {
      shape0.vertex(x-sideSize,
        y+sideSize/w*sin(i*2*PI/nbSide),
        z+sideSize/w*cos(i*2*PI/nbSide));
    }
  }
   else{
     for (int i=0; i<=nbSide; i++) {
       shape0.vertex(x+sideSize/w*cos(i*2*PI/nbSide),
        y+sideSize/w*sin(i*2*PI/nbSide),
        z-sideSize);
    }
  }
  shape0.endShape();

  return shape0;
}

PShape[] createPylonBlocss(float size, int nb_Pylons) {
  PShape pylon_block[]= new PShape[nb_Pylons];;
  // Define the pylon_block
  pylon_block[0] = createShape();
  pylon_block[0].beginShape(LINES);
  pylon_block[0].stroke(0, 0, 0); // Set color to black
  pylon_block[0].strokeWeight(6);
  createPylonBlock(size, pylon_block[0]);
  pylon_block[0].endShape();
  float translation_rate = 0;
  for (int i = 1; i<nb_Pylons; i++) {
    translation_rate+= 2*size*pow(0.9, i);
    pylon_block[i] = createShape();
    pylon_block[i].beginShape(LINES);
    pylon_block[i].stroke(0, 0, 0); // Set color to black
    pylon_block[i].strokeWeight(6);
    pylon_block[i].translate(0, 0, translation_rate);
    createPylonBlock(size*pow(0.9, i), pylon_block[i]);
    pylon_block[i].endShape();
  }
  return pylon_block;
}

void createPylonBlock(float size, PShape pylon_block) {
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

  pylon_block.vertex(-size, -size, -size);
  pylon_block.vertex(size*0.9, -size*0.9, size*0.9);
  pylon_block.vertex(-size*0.9, -size*0.9, size*0.9);
  pylon_block.vertex(size, -size, -size);

  pylon_block.vertex(-size, size, -size);
  pylon_block.vertex(size*0.9, size*0.9, size*0.9);
  pylon_block.vertex(-size*0.9, size*0.9, size*0.9);
  pylon_block.vertex(size, size, -size);

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
  pylon_block.vertex(-size, -size, -size);
  pylon_block.vertex(size, -size, -size);

  pylon_block.vertex(-size*0.9, -size*0.9, 0.9*size);
  pylon_block.vertex(size*0.9, -size*0.9, size*0.9);

  pylon_block.vertex(-size, size, -size);
  pylon_block.vertex(size, size, -size);

  pylon_block.vertex(-size*0.9, size*0.9, size*0.9);
  pylon_block.vertex(size*0.9, size*0.9, size*0.9);

  //y
  pylon_block.vertex(-size, -size, -size);
  pylon_block.vertex(-size, size, -size);

  pylon_block.vertex(-size*0.9, -size*0.9, size*0.9);
  pylon_block.vertex(-size*0.9, size*0.9, size*0.9);

  pylon_block.vertex(size, -size, -size);
  pylon_block.vertex(size, size, -size);

  pylon_block.vertex(size*0.9, -size*0.9, size*0.9);
  pylon_block.vertex(size*0.9, size*0.9, size*0.9);

  //z
  pylon_block.vertex(-size, -size, -size);
  pylon_block.vertex(-size*0.9, -size*0.9, size*0.9);

  pylon_block.vertex(-size, size, -size);
  pylon_block.vertex(-size*0.9, size*0.9, size*0.9);

  pylon_block.vertex(size, -size, -size);
  pylon_block.vertex(size*0.9, -size*0.9, size*0.9);

  pylon_block.vertex(size, size, -size);
  pylon_block.vertex(size*0.9, size*0.9, size*0.9);
}

PShape Create_Pylon(float angle_mort,float size,int nb_Pylons) {
  PShape shape = createShape(GROUP);
  float coneSize = 5*size*pow(0.9, nb_Pylons);
  PShape[] pylon_block = createPylonBlocss(size,nb_Pylons);
  for (int i=0; i <nb_Pylons; i++) {
    shape.addChild(pylon_block[i]);
  }
 
  PShape c = myCone(coneSize, 4, coneSize+size*pow(0.9, nb_Pylons), 0, size*nb_Pylons,4, 0);
  PShape c2 = myCone(coneSize/5*3, 4, coneSize/5*3+size*pow(0.9, nb_Pylons), 0, size*(nb_Pylons+1),4, 0);

  shape.addChild(c);
  shape.addChild(c2);
  c = myCone(coneSize, 4, -coneSize-size*pow(0.9, nb_Pylons), 0, size*nb_Pylons,4, 1);
  c2 = myCone(coneSize/5*3, 4, -coneSize/5*3-size*pow(0.9, nb_Pylons), 0, size*(nb_Pylons+1),4, 1);
  shape.addChild(c);
  shape.addChild(c2);
  //pyramide/chapeau du pylon:
  //les valeurs ne marchent pas pour nimporte quoi,
  //mais vu que le size du pylon ne changera pas, on se permet de fixer
  //manuellement la longueur et la largeur de la pyramide/chapeau du pylon
  c2 = myCone(size*pow(0.9, nb_Pylons-5)*0.85, 4, 0, 0, size*(nb_Pylons+2)+size*pow(0.9,nb_Pylons+6),1, 2);
  c2.rotateZ(PI/4.0);
  shape.addChild(c2);
  //angle_rotation = angle_mort;
  shape.rotateZ(angle_mort);
  return shape;
}


//void draw() {
//  background(255);
//  lights();
//  translate(width/2, height/2);
//  rotateX(PI/2);
//   //rotateZ(frameCount * 0.01);
//  //rotateY(frameCount * 0.01);
//  //shape(cube);
//  //rotateY(mouseY);
//  shape(pylone,0,0);
//  //rotateX(PI/3.0);
//  //translate(
//}
