shader_type canvas_item;

uniform float x_sway = 20.0;
uniform float y_sway = 50.0;
uniform float rotation = 0.0;
uniform vec2 rotation_offset = vec2(0.5, 0.5);

void fragment() {
	float rotation_anchored = (sin(rotation + TIME)/x_sway) * (1.0 - UV.y);
	
	mat2 rotation_mat = mat2(vec2(abs(cos(rotation_anchored)), sin(rotation_anchored)),
							vec2(-sin(rotation_anchored + TIME) / y_sway,  cos(rotation_anchored)));
	
	vec2 centered_uv = UV - rotation_offset;
	vec2 rotated_uv = centered_uv * rotation_mat;
	rotated_uv = rotated_uv + rotation_offset;
	
	//COLOR = texture(TEXTURE, rotated_uv);
	COLOR = texture(TEXTURE, rotated_uv);
}
