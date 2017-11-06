uniform vec3 light;
varying vec3 light_direction;
varying vec3 norm_t;
uniform vec3 ambient;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
varying vec3 pixelPos;
varying vec3 cameraPos;

void main() {

  //AMBIENT
  vec3 light_AMB = ambient * kAmbient;

  float l_dot_n = dot(light_direction, norm_t);
  //DIFFUSE
  vec3 light_DFF = vec3(max(0.0, l_dot_n)) * light * kDiffuse;

  //SPECULAR
  vec3 bounce = normalize(-light_direction + (2.0 * l_dot_n * norm_t));
  vec3 view = normalize(cameraPos - pixelPos);
  float intensity_SPC = max(0.0, dot(bounce, view));
  vec3 light_SPC = vec3(pow(intensity_SPC, shininess)) * light * kSpecular;

  //TOTAL
  vec3 TOTAL = light_AMB + light_DFF + light_SPC;
  gl_FragColor = vec4(TOTAL, 0.0);

}
