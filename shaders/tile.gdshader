shader_type spatial;
render_mode unshaded;
uniform bool selected;


void fragment() {
	bool is_border = false;
	ALPHA = 0.0;
	ALBEDO = vec3(1.0);
	if(UV.x > 0.02 && UV.x < 0.98 && (UV.y > 0.02 && UV.y < 0.1 || UV.y > 0.9 && UV.y < 0.98)) {
		ALPHA = 0.2;
		is_border = true;
	}
	
	if(UV.y > 0.02 && UV.y < 0.98 && (UV.x > 0.02 && UV.x < 0.1||
		UV.x > 0.9 && UV.x < 0.98)) {
		ALPHA = 0.2;
		is_border = true;
	}
	
	if(selected && is_border) {
		ALBEDO = vec3(0.0, 0.0, 1.0);
		ALPHA = 0.8;
	}
}
