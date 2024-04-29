float sizeEol = 10;
int nbEol = 10;

float spRadius = sizeEol /60 , spHeight = sizeEol/40; 

public class Eolienne{
  float x,y,z;
  
  PShape pales,support,tour,forme;
  
  public Eolienne(float x, float y){
    this.x = x;
    this.y = y;
    this.z = get_z(0, 0);
    
    PShape p1 = helice(sizeEol/8,0,0,0);
    PShape p2 = helice(sizeEol/8,0,0,0);
    PShape p3 = helice(sizeEol/8,0,0,0);
    p2.rotateY(2*PI/3);
    p3.rotateY(-2*PI/3);
    
    this.pales = createShape(GROUP);
    this.pales.addChild(p1);
    this.pales.addChild(p2);
    this.pales.addChild(p3);
    
    
    this.tour = cylinder(sizeEol,0.1);
    this.forme = createShape(GROUP);
    this.forme.addChild(pales);
    this.tour.translate(0,-0.1,-sizeEol);
    this.support = createSupport(spRadius,spHeight);
    this.forme.addChild(tour);
    this.support.translate(0,-spHeight/2,0);
    this.forme.addChild(support);
  }
  
  void drawEolienne(){
    pushMatrix();
    pales.rotateY(0.1);
    fill(255);
    translate(x,y,z+sizeEol);
    shape(forme);   
    popMatrix();

  }
  
  
}

PShape helice(float r,float x, float y, float z){
  PShape result = createShape();
  result.beginShape();
  fill(255);
  stroke(255);
  result.vertex(0,0,0);
  result.bezierVertex(r/2,r/16,r/4,4*r,r/20,0,2*r,0,0);
  result.endShape();
  result.translate(x,y,z);
  return result;
}

PShape cylinder(float h, float r) {
  PShape result = createShape(GROUP);
  result.addChild( drawCylinder(r,h));
  result.addChild(drawCircle(r,0,0));
  result.addChild( drawCircle(r,h,0));
  result.rotateX(PI/2);
  
  return result;
}



PShape createSupport(float cylinderRadius , float cylinderHeight){
  PShape r = createShape(GROUP);
  r.addChild(drawCylinder(cylinderRadius,cylinderHeight));
  r.addChild(drawCircle(cylinderRadius,0, 0));
  PShape sph = createShape(SPHERE, cylinderRadius);
  sph.translate(0,cylinderHeight,0);
  r.addChild(sph);
  r.translate(0,-cylinderHeight/2,0);
  return r;
}


PShape drawCylinder(float cylinderRadius , float cylinderHeight) {
  int segments = 360; 
  
  PShape r = createShape();
  r.beginShape(QUAD_STRIP);
  fill(255);
  stroke(255);
  for (int i = 0; i <= segments; i++) {
    float angle = map(i, 0, segments, 0, TWO_PI);
    float x = cos(angle) * cylinderRadius;
    float z = sin(angle) * cylinderRadius;
    
    r.vertex(x, 0, z);
    r.vertex(x, cylinderHeight, z);
  }
  r.endShape();

  return r;
}

PShape drawCircle(float radius, float y, float z) {
  int segments = 50;
  PShape r = createShape();
  r.beginShape(TRIANGLE_FAN);
  fill(255);
  stroke(255);
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
