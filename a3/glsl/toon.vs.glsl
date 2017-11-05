void main() {

	// TODO: PART 1D
   
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}