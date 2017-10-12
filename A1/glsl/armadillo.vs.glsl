// Create shared variable for the vertex and fragment shaders
uniform vec3 lightPosition;
varying vec3 light;

/* HINT: YOU WILL NEED MORE SHARED/UNIFORM VARIABLES TO COLOR ACCORDING TO COS(ANGLE) */

void main() {
    // find the vector to the lightbulb, and then the cos of angle
    vec3 norm = normalize(normal);
    vec3 lightVec = (lightPosition - position);
    float lightIntensity = max(dot(normal, normalize(lightVec)), 0.0);
    float prox = length(lightVec);

    // make the color vary from blue to red based on the distance 0 - 10
    if (lightIntensity > 0.1) {
      float red = max(1.0 - prox/10.0, 0.0);
      float blue = min(prox/10.0, 1.0);
      light = vec3(red, lightIntensity, blue);
    } else {
      light = vec3 (lightIntensity);
    }

    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
