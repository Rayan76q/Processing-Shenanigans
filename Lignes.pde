PShape Ligne;

float zmin = -202.09592, zmax = -179.59933;

float cosh(float x){
return (exp(x)+exp(-x))/2;
}

float f(float a, float x,float beta){
  return cosh(a*x)+x*(1-cosh(beta))-1;
}


PShape create_ligne(LinkedList<PVector> coords,float angle_rotation,float size,int nb_Pylons){
  float nb_points = 20;
  float p1x = coords.get(0).x+0.6*cos(angle_rotation);
  float p1y = coords.get(0).y+0.6*sin(angle_rotation);
  float p1z = coords.get(0).z+ size*(nb_Pylons-3.5)/2.0 -0.051;
  float p2x,p2y,p2z;
  PShape ligne = createShape(GROUP);
  for(int i = 1 ; i<coords.size() ; i++){
    PVector c = coords.get(i);
    p2x = c.x+0.6*cos(angle_rotation);
    p2y = c.y+0.6*sin(angle_rotation);
    p2z = c.z+ size*(nb_Pylons-3.5)/2.0 -0.051;
    
    
    float vx = p2x-p1x , vy = p2y-p1y, ex = vx/nb_points, ey = vy/nb_points;
    float dist = sqrt(vx*vx+vy*vy);
    float difZ = p2z-p1z;
    
    if(difZ>0){
      float beta = 0.7;
      float cnst = difZ +1-dist*(1-cosh(beta));
      float a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      while(get_z(p1x+(vx)/2,p1y+(vy)/2)+1>=p1z+f(a,sqrt(vx*vx+vy*vy)/2,beta) && beta>0.4){
        beta-=0.05;
        cnst = difZ +1-dist*(1-cosh(beta));
        a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      }
      for(int j = 0 ; j<nb_points;j++){
        PShape segment = createShape();
        segment.beginShape(LINES);
        segment.stroke(0);
        segment.strokeWeight(1.5);
        segment.vertex(p1x+ex*j,p1y+ey*j,p1z+f(a,sqrt((ex*j)*(ex*j)+(ey*j)*(ey*j)),beta ));
        segment.vertex(p1x+ex*(j+1),p1y+ey*(j+1),p1z+f(a,sqrt((ex*(j+1))*(ex*(j+1))+(ey*(j+1))*(ey*(j+1))),beta ));
        segment.endShape();
        ligne.addChild(segment);
      }
      
    }
    else{
      float beta = 0.7;
      difZ= -difZ;
      float cnst = difZ +1-dist*(1-cosh(beta));
      float a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      while(get_z(p1x+(vx)/2,p1y+(vy)/2)+1>=p1z+f(a,sqrt(vx*vx+vy*vy)/2,beta) && beta>0.4){
        beta-=0.05;
        cnst = difZ +1-dist*(1-cosh(beta));
        a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      }
      for(int j = 0 ; j<nb_points;j++){
        PShape segment = createShape();
        segment.beginShape(LINES);
        segment.stroke(0);
        segment.strokeWeight(1.5);
        segment.vertex(p1x+ex*j,p1y+ey*j,p2z+f(a,
        sqrt((ex*(nb_points-j))*(ex*(nb_points-j))+(ey*(nb_points-j))*(ey*(nb_points-j))), beta));
        segment.vertex(p1x+ex*(j+1),p1y+ey*(j+1),p2z+f(a,
        sqrt((ex*(nb_points-j-1))*(ex*(nb_points-j-1))+(ey*(nb_points-j-1))*(ey*(nb_points-j-1))),beta ));
        segment.endShape();
        ligne.addChild(segment);
      }
      
    }
    p1x = p2x;
    p1y = p2y;
    p1z = p2z;
  }
   return ligne;
}


PShape create_ligne_box(float angle_rotation,PVector coords,boolean down, boolean right,PVector c,float size,int nb_Pylons){
  float nb_points = 20;
  float len_triangle;
  float upper = 0;
  if(down){
    if(right) len_triangle = 0.6;
    else len_triangle = -0.6;
  }
  else{
    upper = 0.31;
    if(right) len_triangle = 0.4;
    else len_triangle = -0.4;
  }
  float p1x = coords.x+(len_triangle)*cos(angle_rotation);
  float p1y = coords.y+(len_triangle)*sin(angle_rotation);
  float p1z = coords.z+upper+ size*(nb_Pylons-3.5)/2.0 -0.051;
  float p2x,p2y,p2z;
  PShape ligne = createShape(GROUP);
    p2x = c.x;
    p2y = c.y;
    p2z = c.z;
    float vx = p2x-p1x , vy = p2y-p1y, ex = vx/nb_points, ey = vy/nb_points;
    float dist = sqrt(vx*vx+vy*vy);
    float difZ = p2z-p1z;
    if(difZ>0){
      float beta = 0.7;
      float cnst = difZ +1-dist*(1-cosh(beta));
      float a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      while(get_z(p1x+(vx)/2,p1y+(vy)/2)+1>=p1z+f(a,sqrt(vx*vx+vy*vy)/2,beta) && beta>0.4){
        beta-=0.05;
        cnst = difZ +1-dist*(1-cosh(beta));
        a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      }
      for(int j = 0 ; j<nb_points;j++){
        PShape segment = createShape();
        segment.beginShape(LINES);
        segment.stroke(0);
        segment.strokeWeight(1.5);
        segment.vertex(p1x+ex*j,p1y+ey*j,p1z+f(a,sqrt((ex*j)*(ex*j)+(ey*j)*(ey*j)),beta ));
        segment.vertex(p1x+ex*(j+1),p1y+ey*(j+1),p1z+f(a,sqrt((ex*(j+1))*(ex*(j+1))+(ey*(j+1))*(ey*(j+1))),beta ));
        segment.endShape();
        ligne.addChild(segment);
      }
    }
    else{
      float beta = 0.7;
      difZ= -difZ;
      float cnst = difZ +1-dist*(1-cosh(beta));
      float a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      while(get_z(p1x+(vx)/2,p1y+(vy)/2)+1>=p1z+f(a,sqrt(vx*vx+vy*vy)/2,beta) && beta>0.4){
        beta-=0.05;
        cnst = difZ +1-dist*(1-cosh(beta));
        a = log(cnst+ sqrt(cnst*cnst -1))/dist;
      }
      for(int j = 0 ; j<nb_points;j++){
        PShape segment = createShape();
        segment.beginShape(LINES);
        segment.stroke(0);
        segment.strokeWeight(1.5);
        segment.vertex(p1x+ex*j,p1y+ey*j,p2z+f(a,
        sqrt((ex*(nb_points-j))*(ex*(nb_points-j))+(ey*(nb_points-j))*(ey*(nb_points-j))), beta));
        segment.vertex(p1x+ex*(j+1),p1y+ey*(j+1),p2z+f(a,
        sqrt((ex*(nb_points-j-1))*(ex*(nb_points-j-1))+(ey*(nb_points-j-1))*(ey*(nb_points-j-1))),beta ));
        segment.endShape();
        ligne.addChild(segment);
      }
  }
   return ligne;
}

PShape create_ground_ligne(PVector src, Eolienne tgt){
  float p1x = src.x ,p1y = src.y;
  float p2x = tgt.x, p2y = tgt.y;
  float nb_points = 100;
  float vx = p2x-p1x , vy = p2y-p1y, ex = vx/nb_points, ey = vy/nb_points;
  PShape ligne = createShape(GROUP);
  for(int j = 0 ; j<nb_points;j++){
        PShape segment = createShape();
        segment.beginShape(LINES);
        segment.stroke(0);
        segment.strokeWeight(4);
        segment.vertex(p1x+ex*j,p1y+ey*j,get_z(p1x+ex*j,p1y+ey*j)+0.4);
        segment.vertex(p1x+ex*(j+1),p1y+ey*(j+1),get_z(p1x+ex*(j+1),p1y+ey*(j+1))+0.4);
        segment.endShape();
        ligne.addChild(segment);
      }
   return ligne;
}
