uniform vec3 eye;
uniform vec3 lightPosition;
uniform vec3 up;
uniform float laserLength;

#define PI 3.1415926535

void main() {

  float angle = -PI/2.0;
  mat4 rotate_x = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                       vec4(0.0, cos(angle), sin(angle), 0.0),
                       vec4(0.0, -sin(angle), cos(angle), 0.0),
                       vec4(0.0, 0.0, 0.0, 1.0));

  vec3 trace = eye - lightPosition;
  float distance = length(trace);

  mat4 scale = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                    vec4(0.0, 1.0, 0.0, 0.0),
                    vec4(0.0, 0.0, distance/laserLength, 0.0),
                    vec4(0.0, 0.0, 0.0, 1.0));

  vec3 lookAt_z = normalize(trace);
  vec3 lookAt_x = normalize(cross(up, lookAt_z));
  vec3 lookAt_y = cross(lookAt_z, lookAt_x);

  mat4 lookAt = mat4(vec4(lookAt_x, 0.0),
                     vec4(lookAt_y, 0.0),
                     vec4(lookAt_z, 0.0),
                     vec4(eye, 1.0));

  gl_Position = projectionMatrix * viewMatrix * lookAt * modelMatrix * scale * rotate_x * vec4(position, 1.0);
}
