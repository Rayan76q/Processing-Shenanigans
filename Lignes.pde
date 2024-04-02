PShape Ligne;


float f(float a , float b,float x){
  return (exp((1/a)*x+ b/2)+exp((1/a)*x+ b/2))/2 ;
}


PShape create_ligne(float[] p1 , float[] p2 , int nb_pylone){
  assert nb_pylone > 0;
  assert p1.length > 1 && p2.length >1;
  
  
  PShape ligne = createShape(GROUP);
 
  int nb = 100; //nombre de points pour tracer un segment;
  float vx  = (p2[0]-p1[0])/nb_pylone, vy = (p2[1]-p1[1])/nb_pylone,ex=vx/nb,ey=vy/nb;
  float dist = sqrt(vx*vx + vy*vy);
  for(int i=0 ; i < nb_pylone ; i++){
    float difZ = get_z(p1[0]+vx*(i+1),p1[1]+vy*(i+1)) - get_z(p1[0]+vx*i,p1[1]+vy*i);
    for(int j = 0 ; j < 100 ; j++){
      PShape segment = createShape();
      segment.beginShape(LINES);
      segment.stroke(0,0,0);
      segment.strokeWeight(4);
      segment.vertex(p1[0]+ex*j,p1[1]+ex*j, get_z(p1[0]+ey*j,p1[1]+ey*j) + f(dist , difZ, -dist + dist/nb * j));
      segment.vertex(p1[0]+ex*(j+1),p1[1]+ex*(j+1),  get_z(p1[0]+ey*(j+1),p1[1]+ey*(j+1)) + f(dist , difZ, -dist + dist/nb * (j+1)));
      segment.endShape();
      ligne.addChild(segment);
    }
   } 
   ligne.endShape();
   return ligne;
  
}
  
