#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform int day;

varying vec4 vertColor;
varying vec4 vertTexCoord;
varying float z;

void main() {
  float zmin = -202.09592, zmax = -179.59933;
  vec4 color = vec4(1.0);

  if((-int(z*2))%5 == 0){
    color = vec4(vec3(0.4) , 1.0);
  }
  else{
    if(day <= 90){
      float hauteurs = zmax - (zmax-zmin)*(day<=45 ? day : 90-day)/45 * 2/5 ;
      if(z>=hauteurs) {color = vec4(255,255,255,1);}
    }

    if(45 < day && day <= 180)
    {
      float vallee = zmin + (zmax-zmin)*(day*2-45)/180 * 1/7 ;
      if(z<=vallee) {color = vec4(0.25 , 2.0,0.25 , 1.0);}
    }
    if(day > 180 && day <=300){
      float vallee = zmin + (zmax-zmin)*(360-45)/180 * 1/7 ;
      if(z<=vallee) {color = vec4(0.25+(float(day-180))/40.0 , 2.0,0.25 , 1.0);}
    }
    if(day > 300 && day <=360){
      float vallee = zmin + (zmax - zmin) * (315 - 6 * (day - 300)) / 180 * 1 / 7;
      if(z<=vallee) {color = vec4(0.25+(300-180)/50 , 2.0,0.25 , 1.0);}
    }
  }


  gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor*color;
}