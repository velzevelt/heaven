shader_type spatial;
render_mode unshaded;

uniform sampler2D albedo;

void fragment() {
	vec2 screen_pos_UV = UV.xy;
	vec4 t = textureLod(albedo, screen_pos_UV, 0.0);
	ALBEDO = vec3(t.rgb);
	
}

