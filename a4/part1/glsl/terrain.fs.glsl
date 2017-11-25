//VARYING VAR
varying vec3 Normal_V;
varying vec3 Position_V;
varying vec4 PositionFromLight_V;
varying vec2 Texcoord_V;

//UNIFORM VAR
uniform vec3 lightColorUniform;
uniform vec3 ambientColorUniform;
uniform vec3 lightDirectionUniform;

uniform float kAmbientUniform;
uniform float kDiffuseUniform;
uniform float kSpecularUniform;

uniform float shininessUniform;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform sampler2D aoMap;
uniform sampler2D shadowMap;

// PART D)
// Use this instead of directly sampling the shadowmap, as the float
// value is packed into 4 bytes as WebGL 1.0 (OpenGL ES 2.0) doesn't
// support floating point bufffers for the packing see depth.fs.glsl
float getShadowMapDepth(vec2 texCoord)
{
	vec4 v = texture2D(shadowMap, texCoord);
	const vec4 bitShift = vec4(1.0, 1.0/256.0, 1.0/(256.0 * 256.0), 1.0/(256.0*256.0*256.0));
	return dot(v, bitShift);
}

void main() {
	// PART B) TANGENT SPACE NORMAL
	vec3 N_1 = normalize(texture2D(normalMap, Texcoord_V).xyz * 2.0 - 1.0);

	// PRE-CALCS
	vec3 N = normalize(Normal_V);

    // tangent space transformative matrix:
    vec3 T = normalize(cross(N, vec3(0.0, 1.0, 0.0)));
    vec3 B = normalize(cross(N, T));
    mat3 TBN = mat3(T, B, N);

	vec3 L_orig = normalize(vec3(viewMatrix * vec4(lightDirectionUniform, 0.0)));
	vec3 V_orig = normalize(-Position_V);
    // need TBN^-1 * [thing].
    // "post-multiplying with column-major matrices produces the same result as pre-multiplying with row-major matrices"
    // inverse(TBN) = transpose(TBN) b/c TBN is orthogonal
    vec3 L = L_orig * TBN;
    vec3 V = V_orig * TBN;
	vec3 H = normalize(V + L);

	// AMBIENT
	vec3 light_AMB = kAmbientUniform * texture2D(aoMap, Texcoord_V).xyz;

	// DIFFUSE
	vec3 diffuse = kDiffuseUniform * texture2D(colorMap, Texcoord_V).xyz;
	vec3 light_DFF = diffuse * max(0.0, dot(N_1, L));

	// SPECULAR
	vec3 specular = kSpecularUniform * lightColorUniform;
	vec3 light_SPC = specular * pow(max(0.0, dot(H, N_1)), shininessUniform);

	// TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;

	// SHADOW
	// Fill in attenuation for shadow here
    float length_from_light = PositionFromLight_V.z;

    float texture_x = PositionFromLight_V.x;
    float texture_y = PositionFromLight_V.y;

    float shadow_map_dist = getShadowMapDepth(vec2(texture_x+1.0, texture_y+1.0));

    if(shadow_map_dist < length_from_light) {
        float thing = texture_x + texture_y;
        TOTAL = vec3(1.0, 0.0, 1.0);
    }

	gl_FragColor = vec4(TOTAL, 1.0);
}
