PShape Ligne;


float f(float a, float b, float x) {
  return (exp((1/a)*x+ b/2)+exp((1/a)*x+ b/2))/2 ;
}


PShape create_ligne(float[] p1, float[] p2, int nb_pylone) {
  assert nb_pylone > 0;
  assert p1.length > 1 && p2.length >1;


  PShape ligne = createShape(GROUP);

  int nb = 40; //nombre de points pour tracer un segment;
  float vx  = (p2[0]-p1[0])/nb_pylone, vy = (p2[1]-p1[1])/nb_pylone; //vecteur directeur d'un pylone
  float ex=vx/nb, ey=vy/nb;  //veteur directeur d'un point
  float dist = sqrt(vx*vx + vy*vy);
  for (int i=0; i < nb_pylone; i++) {
    float difZ = get_z(p1[0]+vx*(i+1), p1[1]+vy*(i+1)) - get_z(p1[0]+vx*i, p1[1]+vy*i);
    for (int j = 0; j < nb; j++) {
      PShape segment = createShape();
      segment.beginShape(LINES);
      segment.stroke(0, 0, 0);
      segment.strokeWeight(2);
      segment.vertex(p1[0]+vx*i+ex*j, p1[1]+vy*i+ey*j, get_z(p1[0]+vx*i+ex*j, p1[1]+vy*i+ey*j) + f(dist, difZ, -dist + dist/nb * j));
      segment.vertex(p1[0]+vx*i+ex*(j+1), p1[1]+vy*i+ey*(j+1), get_z(p1[0]+vx*i+ex*(j+1), p1[1]+vy*i+ey*(j+1)) + f(dist, difZ, -dist + dist/nb * (j+1)));
      segment.endShape();
      ligne.addChild(segment);
    }
  }
 
  
  return ligne;
}
