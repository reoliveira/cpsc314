// UNIFORMS
uniform samplerCube skybox;

// VARYING
varying vec3 view_vec;

void main() {
	gl_FragColor = textureCube(skybox, view_vec);
}
