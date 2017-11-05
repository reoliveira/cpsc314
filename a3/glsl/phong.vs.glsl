uniform vec3 light_d;
varying vec3 norm_t;
varying vec3 light_direction;
varying vec3 pixelPos;
varying vec3 cameraPos;

void main() {

	// TODO: PART 1A

    norm_t = normalize(normalMatrix * normal);
    vec4 transform_light = normalize(viewMatrix * vec4(light_d, 0.0));
    light_direction = vec3(transform_light);

    pixelPos = vec3(modelViewMatrix * vec4(position, 1.0));
    cameraPos = vec3(viewMatrix * vec4(cameraPosition, 1.0));

    gl_Position = projectionMatrix * vec4(pixelPos, 1.0);
}
