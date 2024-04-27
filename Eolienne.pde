float HEOLIENNE = 10;
int NBEOLIENNE = 10;

public class Eolienne{
  float x;
  float y;
  float z;
  
  PShape pales;
  
  PShape tour;
  
  PShape forme;
  
  public Eolienne(float x, float y){
    this.x = x;
    this.y = y;
    this.z = get_z(0, 0);
    
    PShape h1 = helice(HEOLIENNE/5,0,0,0);
    PShape h2 = helice(HEOLIENNE/5,0,0,0);
    PShape h3 = helice(HEOLIENNE/5,0,0,0);
    
    h2.rotateY(2*PI/3);
    h3.rotateY(-2*PI/3);
    
    PShape tmp = createShape(GROUP);
    tmp.addChild(h1);
    tmp.addChild(h2);
    tmp.addChild(h3);
    
    pales = tmp;
    
    this.tour = cylinder(HEOLIENNE,0.1);
    
    this.forme = createShape(GROUP);
    this.forme.addChild(pales);
    this.tour.translate(0,-0.1,-HEOLIENNE);
    this.forme.addChild(tour);

  }
  
  void drawEolienne(){
    //fill(255);
    //pushMatrix();
    //translate(x,y,z+HEOLIENNE);
    //shape(pales);
    //pales.rotateY(0.01);
    //PShape tour = cylinder(HEOLIENNE,0.2);
    //pushMatrix();
    //translate(x,y-0.4,-HEOLIENNE);
    //sphere(0.4);
    //pushMatrix();
    //noStroke();
    //translate(x,y,HEOLIENNE);
    //sphere(0.4);
    //popMatrix();
    //shape(tour);
    //popMatrix();
    //popMatrix();   
    pushMatrix();
    translate(x,y,z+HEOLIENNE);
    shape(forme);
    pales.rotateY(0.01);     
    //
    //translate(x,-HEOLIENNE/100,z);
    noStroke();
    fill(255);
    sphere(0.15);
    popMatrix();
    

  }
}

PShape helice(float r,float x, float y, float z){
  PShape ret = createShape();
  noStroke();

  ret.beginShape();
  ret.vertex(0,0,0);
  ret.bezierVertex(r/2,r/16,r/4,r,r/20,0,2*r,0,0);
  ret.endShape();
  ret.translate(x,y,z);
  return ret;
}

PShape cylinder(float h, float r) {
  PShape cylinder = createShape(GROUP);
  noStroke();
  // Corps du cylindre
  PShape body = createShape();
  body.beginShape(QUAD_STRIP);
  for (int i = 0; i <= 360; i += 20) {
    float x = cos(radians(i)) * r;
    float y = sin(radians(i)) * r;
    body.vertex(x, y, 0);
    body.vertex(x, y, h);
  }
  body.endShape();
  cylinder.addChild(body);
  
  // Bases du cylindre
  PShape topBase = createShape();
  topBase.beginShape(TRIANGLE_FAN);
  topBase.vertex(0, 0, h);
  for (int i = 0; i <= 360; i += 20) {
    float x = cos(radians(i)) * r;
    float y = sin(radians(i)) * r;
    topBase.vertex(x, y, h);
  }
  topBase.endShape(CLOSE);
  cylinder.addChild(topBase);
  
  PShape bottomBase = createShape();
  bottomBase.beginShape(TRIANGLE_FAN);
  bottomBase.vertex(0, 0, 0);
  for (int i = 0; i <= 360; i += 20) {
    float x = cos(radians(i)) * r;
    float y = sin(radians(i)) * r;
    bottomBase.vertex(x, y, 0);
  }
  bottomBase.endShape(CLOSE);
  cylinder.addChild(bottomBase);
  stroke(0);
  
  return cylinder;
}


//PShape tourEolienne(float h, float r){
//  PShape ret = createShape();
//  ret.beginShape(QUADS);
//  ret.vertex(0,0,0);
//  ret.vertex(0,0,h);
//  ret.vertex(r,0,h);
//  ret.vertex(r,0,0);
  
//  ret.vertex();
//  ret.vertex();
//  ret.vertex();
//  ret.vertex();
  
//  //ret.vertex();
//  //ret.vertex();
//  //ret.vertex();
//  //ret.vertex();
//  ret.endShape(CLOSE);
//  return ret;
//}
