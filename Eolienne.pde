float HEOLIENNE = 10;
int NBEOLIENNE = 10;

float spRadius = HEOLIENNE /60 , spHeight = HEOLIENNE/40; 

public class Eolienne{
  float x;
  float y;
  float z;
  
  PShape pales;
  PShape support;
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
    this.support = createSupport(spRadius,spHeight);
    this.forme.addChild(tour);
    this.support.translate(0,-spHeight/2,0);
    this.forme.addChild(support);
  }
  
  void drawEolienne(){
   
    pushMatrix();
    translate(x,y,z+HEOLIENNE);
    shape(forme);
    pales.rotateY(0.01);     
    popMatrix();
    

  }
}

PShape helice(float r,float x, float y, float z){
  PShape ret = createShape();
  noStroke();

  ret.beginShape();
  ret.vertex(0,0,0);
  ret.bezierVertex(r/10, r/16, r/4, 4*r, r/20, 0, r, 0, 0);
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



PShape createSupport(float cylinderRadius , float cylinderHeight){
  PShape r = createShape(GROUP);
  fill(0);
  r.addChild(drawCylinder(cylinderRadius,cylinderHeight));
  r.addChild(drawCircle(cylinderRadius,-cylinderHeight/2, 0));
  PShape sph = createShape(SPHERE, cylinderRadius);
  sph.translate(0,cylinderHeight/2,0);
  r.addChild(sph);

  return r;
}


PShape drawCylinder(float cylinderRadius , float cylinderHeight) {
  int segments = 50; // Number of segments to approximate the cylinder
  
  PShape r = createShape();
  r.beginShape(QUAD_STRIP);
  for (int i = 0; i <= segments; i++) {
    float angle = map(i, 0, segments, 0, TWO_PI);
    float x = cos(angle) * cylinderRadius;
    float z = sin(angle) * cylinderRadius;
    
    r.vertex(x, -cylinderHeight/2, z);
    r.vertex(x, cylinderHeight/2, z);
  }
  r.endShape();

  return r;
}

PShape drawCircle(float radius, float y, float z) {
  int segments = 50;
  PShape r = createShape();
  r.beginShape(TRIANGLE_FAN);
  noStroke();
  r.vertex(0, y, z);
  for (int i = 0; i <= segments; i++) {
    float angle = map(i, 0, segments, 0, TWO_PI);
    float x = cos(angle) * radius;
    float z2 = sin(angle) * radius;
    r.vertex(x, y, z2);
  }
  r.endShape();
  return r;
}
