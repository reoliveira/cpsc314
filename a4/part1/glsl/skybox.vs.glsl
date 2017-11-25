varying vec3 view_vec;

void main() {
    view_vec = position - cameraPosition;
	gl_Position = projectionMatrix * viewMatrix * vec4(position, 1.0);
}
