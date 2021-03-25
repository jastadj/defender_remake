shader_type canvas_item;
uniform sampler2D TextureUniform;

void fragment() {
// Input:3
	vec3 n_out3p0 = vec3(SCREEN_UV, 0.0);

// VectorOp:4
	vec3 n_in4p1 = vec3(2.00000, 1.00000, 1.00000);
	vec3 n_out4p0 = n_out3p0 * n_in4p1;

// TextureUniform:2
	vec3 n_out2p0;
	float n_out2p1;
	{
		vec4 n_tex_read = texture(TextureUniform, n_out4p0.xy);
		n_out2p0 = n_tex_read.rgb;
		n_out2p1 = n_tex_read.a;
	}

// Output:0
	COLOR.rgb = n_out2p0;
	COLOR.a = n_out2p1;

}

