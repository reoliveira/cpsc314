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
uniform float alphaX;
uniform float alphaY;

void main() {

	float l_dot_n = dot(light_direction, norm_t);
  vec3 up = vec3(0.0, 1.0, 0.0);

  //AMBIENT
	vec3 light_AMB = ambient * kAmbient;

	//DIFFUSE
	vec3 light_DFF = vec3(max(0.0, l_dot_n)) * light * kDiffuse;

	//SPECULAR
  vec3 view = normalize(cameraPos - pixelPos);
  vec3 halfway = normalize(light_direction + view);
  vec3 T = normalize(cross(norm_t, up));
  vec3 B = normalize(cross(norm_t, T));
  float v_dot_n = dot(view, norm_t);

  float exponent = -2.0 *
  (pow((dot(halfway, T)/alphaX), 2.0) + pow((dot(halfway, B)/alphaY), 2.0)) /
  (1.0 + dot(halfway, norm_t));

  float intensity_SPC = sqrt(max(0.0, l_dot_n/v_dot_n)) * exp(exponent);
  vec3 light_SPC = vec3(kSpecular * intensity_SPC) * light;

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

}
