// Shared variable passed to the fragment shader
varying vec3 color;
uniform float eye;
uniform vec3 lightPosition;
uniform vec3 up;

#define MAX_EYE_DEPTH 0.15
#define PI 3.1415926535

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  // position is in local space, assuming radius 1
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

  mat4 scale = mat4(vec4(0.15, 0.0, 0.0, 0.0),
                    vec4(0.0, 0.15, 0.0, 0.0),
                    vec4(0.0, 0.0, 0.15, 0.0),
                    vec4(0.0, 0.0, 0.0, 1.0));

  float angle = -PI/2.0;
  mat4 rotate_x = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                       vec4(0.0, cos(angle), sin(angle), 0.0),
                       vec4(0.0, -sin(angle), cos(angle), 0.0),
                       vec4(0.0, 0.0, 0.0, 1.0));

  mat4 rotate_z = mat4(vec4(cos(angle), sin(angle), 0.0, 0.0),
                       vec4(-sin(angle), cos(angle), 0.0, 0.0),
                       vec4(0.0, 0.0, 1.0, 0.0),
                       vec4(0.0, 0.0, 0.0, 1.0));

  mat4 adjust = rotate_z * rotate_x * scale;

  vec3 eye_pos = vec3(eye * 0.13, 2.45, -0.65);
  vec3 lookAt_z = normalize(eye_pos - lightPosition);
  vec3 lookAt_x = normalize(cross(up, lookAt_z));
  vec3 lookAt_y = cross(lookAt_z, lookAt_x);

  mat4 lookAt = mat4(vec4(lookAt_x, 0.0),
                     vec4(lookAt_y, 0.0),
                     vec4(lookAt_z, 0.0),
                     vec4(eye_pos, 1.0));

  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  gl_Position = projectionMatrix * viewMatrix * lookAt * modelMatrix * adjust * vec4(position, 1.0);
}
