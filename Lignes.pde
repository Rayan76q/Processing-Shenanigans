PShape Ligne;


float cosh(float x){
return (exp(x)+exp(-x))/2;
}

float f(float a, float b, float x) {
  return cosh(1/a * x + b/2) - a/10 ;
}




PShape create_ligne(float[] p1, float[] p2, int nb_pylone) {
  assert nb_pylone > 0;
  assert p1.length > 1 && p2.length >1;


  PShape ligne = createShape(GROUP);

  int nb = 50; //nombre de points pour tracer un segment;
  float vx  = (p2[0]-p1[0])/nb_pylone, vy = (p2[1]-p1[1])/nb_pylone; //vecteur d'un pylone à un autre
  float ex=vx/nb, ey=vy/nb;  //veteur d'un point à un autre
  float dist = sqrt(vx*vx + vy*vy);
  float a = dist/2;
  for (int i=0; i < nb_pylone; i++) {
    
    float p1x = p1[0]+vx*i;
    float p1y = p1[1]+vy*i;
    float p2x = p1[0]+vx*(i+1);
    float p2y = p1[1]+vy*(i+1);
    float p1z = get_z(p1x, p1y);
    float p2z = get_z(p2x,p2y) ;
    float difZ = p2z  - p1z;
    if(difZ>=0){
      for(int j = 0 ; j < nb; j++){
         PShape segment = createShape();
            segment.beginShape(LINES);
            segment.stroke(0, 0, 0);
            segment.strokeWeight(2);
            segment.vertex(-coneSize/2+p1x+ex*j, p1y+ey*j, p2z+size*(2.7) - difZ*sin((nb - j)*PI/(2*nb) ));
            segment.vertex(-coneSize/2+p1x+ex*(j+1), p1y+ey*(j+1),p2z+size*(2.7) - difZ*sin((nb -j-1)*PI/(2*nb)));
            segment.endShape();
            ligne.addChild(segment);
      }
    }
    else{
      for(int j = 0 ; j < nb; j++){
         PShape segment = createShape();
            segment.beginShape(LINES);
            segment.stroke(0, 0, 0);
            segment.strokeWeight(2);
            segment.vertex(-coneSize/2+p1x+ex*j, p1y+ey*j, p1z +size*(2.7)+ difZ*sin(j*PI/(2*nb) ));
            segment.vertex(-coneSize/2+p1x+ex*(j+1), p1y+ey*(j+1),p1z +size*(2.7)+ difZ*sin((j+1)*PI/(2*nb)));
            segment.endShape();
            ligne.addChild(segment);
      }
    }
  }
 
  
  return ligne;
}
