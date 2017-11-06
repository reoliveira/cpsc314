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

  float lightIntensity = length(TOTAL);
  vec4 resultingColor;

  // quantize
  if(lightIntensity > 1.2) {
    resultingColor = vec4(1.0, 1.0, 1.0, 0.0);
  } else if(lightIntensity > 1.0){
    resultingColor = vec4(0.7, 0.5, 0.9, 0.0);
  } else if(lightIntensity > 0.8){
    resultingColor = vec4(0.4, 0.3, 0.6, 0.0);
  } else if(lightIntensity > 0.5){
    resultingColor = vec4(0.2, 0.0, 0.4, 0.0);
  } else {
    resultingColor = vec4(0.1, 0.0, 0.3, 0.0);
  }

  // silhouette objects

  float n_dot_v = dot(norm_t, view);
  if(n_dot_v > -0.1 && n_dot_v < 0.1) {
    resultingColor = vec4(0.05, 0.0, 0.05, 0.0);
  }

  gl_FragColor = resultingColor;
}
