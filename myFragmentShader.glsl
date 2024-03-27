#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;
varying float z;

void main() {
  float zmin = -202.09592, zmax = -179.59933;

  float vallee = (zmax-zmin)/5 + zmin ;
  vec4 color = vec4(1.0);
  if((-int(z*2))%5 == 0){
    color = vec4(vec3(0.4) , 1.0);
  }
  if(z<=vallee ){
    color = vec4(0.25 , 2.0,0.25 , 1.0);
  }


  gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor * color;
}