void main() {

	//TODO: PART 1C

	//AMBIENT
	vec3 light_AMB = vec3(0.1, 0.1, 0.1);

	//DIFFUSE
	vec3 light_DFF = vec3(0.1, 0.1, 0.1);

	//SPECULAR
	vec3 light_SPC = vec3(0.1, 0.1, 0.1);

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

}