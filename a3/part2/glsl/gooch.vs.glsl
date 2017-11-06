uniform vec3 light_d;
varying vec3 norm_t;
varying vec3 light_direction;

void main() {

  norm_t = normalize(normalMatrix * normal);
  vec4 transform_light = normalize(viewMatrix * vec4(light_d, 0.0));
  light_direction = vec3(transform_light);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
