// Shared variable passed to the fragment shader
varying vec3 color;

// Constant set via your javascript code
uniform vec3 lightPosition;

void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);

	// Identifying the head
	if (position.z < -0.33 && abs(position.x) < 0.46)
		color = vec3(1.0, 0.0, 1.0);

	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
