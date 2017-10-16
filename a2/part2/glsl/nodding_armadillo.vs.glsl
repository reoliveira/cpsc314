// Shared variable passed to the fragment shader
varying vec3 color;
uniform float headRotation;
uniform float armRotation;

// Constant set via your javascript code
uniform vec3 lightPosition;

void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);

	vec4 p = vec4(position, 1.0);

	// Identifying the head
	if (position.z < -0.33 && abs(position.x) < 0.46){

		mat4 H = mat4(vec4(1.0, 0.0, 0.0, 0.0),
									vec4(0.0, 1.0, 0.0, 0.0),
									vec4(0.0, 0.0, 1.0, 0.0),
								  vec4(0.0, 2.5, -0.3, 1.0));

		mat4 head_rotate_x = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                  			 vec4(0.0, cos(headRotation), sin(headRotation), 0.0),
	                			 vec4(0.0, -sin(headRotation), cos(headRotation), 0.0),
                  			 vec4(0.0, 0.0, 0.0, 1.0));

		mat4 H_inv = mat4(vec4(1.0, 0.0, 0.0, 0.0),
										  vec4(0.0, 1.0, 0.0, 0.0),
											vec4(0.0, 0.0, 1.0, 0.0),
											vec4(0.0, -2.5, 0.3, 1.0));

		p = H * head_rotate_x * H_inv * p;
	}

	// Identifying the arms
	if (abs(position.x) > 0.55 && position.y > 1.5) {
		float arm = 1.0;
		if (position.x <= 0.0)
			arm = -arm;

		mat4 A = mat4(vec4(1.0, 0.0, 0.0, 0.0),
									vec4(0.0, 1.0, 0.0, 0.0),
									vec4(0.0, 0.0, 1.0, 0.0),
									vec4(arm * 0.55, 2.0, 0.2, 1.0));

    float lower_arm = -0.6;
		mat4 arm_rotate_x = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                  			 vec4(0.0, cos(lower_arm), sin(lower_arm), 0.0),
	                			 vec4(0.0, -sin(lower_arm), cos(lower_arm), 0.0),
                  			 vec4(0.0, 0.0, 0.0, 1.0));

		mat4 arm_rotate_y = mat4(vec4(cos(arm * armRotation), 0.0, -sin(arm * armRotation), 0.0),
											 	 vec4(0.0, 1.0, 0.0, 0.0),
											 	 vec4(sin(arm * armRotation), 0.0, cos(arm * armRotation), 0.0),
											 	 vec4(0.0, 0.0, 0.0, 1.0));

	  mat4 A_inv = mat4(vec4(1.0, 0.0, 0.0, 0.0),
											vec4(0.0, 1.0, 0.0, 0.0),
											vec4(0.0, 0.0, 1.0, 0.0),
											vec4(arm * -0.55, -2.0, -0.2, 1.0));

		p = A * arm_rotate_y * arm_rotate_x * A_inv * p;
		//color = vec3(1.0, 0.0, 1.0);
	}

	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * p;
}
