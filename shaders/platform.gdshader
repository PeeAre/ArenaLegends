shader_type spatial;
render_mode unshaded;
uniform bool enable;


void fragment() {
	if(enable) {
		if(UV.x > 0.33 && UV.x < 0.667 && UV.y > 0.5 && UV.y < 0.54) {
		ALBEDO = vec3(0.05);
		}
		
		if(UV.y > 0.96 && UV.x < 0.667) {
			ALBEDO = vec3(0.05);
		}
		
		if(UV.y > 0.96 && UV.x < 0.667) {
			ALBEDO = vec3(0.05);
		}
		
		if(UV.y > 0.5 && UV.x > 0.33 && UV.x < 0.36) {
			ALBEDO = vec3(0.05);
		}
		
		if(UV.y > 0.5 && UV.x > 0.64 && UV.x < 0.667) {
			ALBEDO = vec3(0.05);
		}
	}
}
