uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;
uniform mat4 texMatrix;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertexCoord;

attribute vec4 texCoord;

void main() {
  vec4 nposition= vec4(position.x, position.y,position.z,0.0);
  gl_Position   = transform * nposition;
  vertColor     = color;
  vertNormal    = normalMatrix * normal;
  vertLightDir  = -lightNormal;
  vertexCoord = texCoord;
  
}