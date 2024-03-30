PShape pylon_block[];
int nb_Pylons=9;
PShape pylone;
float size = 1;
float coneSize = 5*size*pow(0.9, nb_Pylons);
//void setup() {
// size(400, 400, P3D);
//  createPylonBlocss(size);
//  pylone = Create_Pylon();
//}

PShape myCone(float sideSize, int nbSide, float x, float y, float z, boolean left) {
  PShape shape0 = createShape();
  shape0.beginShape(TRIANGLE_FAN);
  shape0.fill(128);
  shape0.noStroke();
  shape0.vertex(x, y, z);
  if (left) {
    for (int i=0; i<=nbSide; i++) {
      shape0.vertex(x+sideSize,
        y+sideSize/4*sin(i*2*PI/nbSide),
        z+sideSize/4*cos(i*2*PI/nbSide));
    }
  } else {
    for (int i=0; i<=nbSide; i++) {
      shape0.vertex(x-sideSize,
        y+sideSize/4*sin(i*2*PI/nbSide),
        z+sideSize/4*cos(i*2*PI/nbSide));
    }
  }
  shape0.endShape();

  return shape0;
}

void createPylonBlocss(float size) {
  pylon_block = new PShape[nb_Pylons];
  // Define the pylon_block
  pylon_block[0] = createShape();
  pylon_block[0].beginShape(LINES);
  pylon_block[0].stroke(0, 0, 0); // Set color to black
  pylon_block[0].strokeWeight(0.5);
  createPylonBlock(size, pylon_block[0]);
  pylon_block[0].endShape();
  int translation_rate = 0;
  for (int i = 1; i<nb_Pylons; i++) {
    translation_rate+= 2*size*pow(0.9, i);
    pylon_block[i] = createShape();
    pylon_block[i].beginShape(LINES);
    pylon_block[i].stroke(0, 0, 0); // Set color to black
    pylon_block[i].strokeWeight(0.5);
    pylon_block[i].translate(0, 0, translation_rate);
    createPylonBlock(size*pow(0.9, i), pylon_block[i]);
    pylon_block[i].endShape();
  }
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

PShape Create_Pylon() {
  PShape shape = createShape(GROUP);
  for (int i=0; i <nb_Pylons; i++) {
    shape.addChild(pylon_block[i]);
  }
 
  PShape c = myCone(coneSize, 200, coneSize+size*pow(0.9, nb_Pylons), 0, size*nb_Pylons, false);

  shape.addChild(c);
  c = myCone(coneSize, 200, -coneSize-size*pow(0.9, nb_Pylons), 0, size*nb_Pylons, true);

  shape.addChild(c);

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