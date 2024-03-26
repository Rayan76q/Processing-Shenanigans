#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertexCoord;


void main() {
  vec4 color;
  color = vec4(1.0);
  float z = vertexCoord.z;
  if( floatBitsToInt(z)%50<=10){
    color = vec4(vec3(1.0), 1.0);
  }
  

  gl_FragColor = color * vertColor;
} 