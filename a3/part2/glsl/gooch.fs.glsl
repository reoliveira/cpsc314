varying vec3 light_direction;
varying vec3 norm_t;

void main() {

  vec3 warm = vec3(1.0, 1.0, 0.3);
  vec3 cool = vec3(0.2, 0.2, 0.2);

  vec3 light_DFF = vec3(max(0.0, dot(light_direction, norm_t)));

  //TOTAL
  vec3 TOTAL = mix(cool, warm, light_DFF);
  gl_FragColor = vec4(TOTAL, 0.0);

}
