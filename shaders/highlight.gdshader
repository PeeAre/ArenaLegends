shader_type spatial;
render_mode unshaded;

float plot(vec2 st, float pct) {
	st = 1.0 - st;
	return smoothstep(pct - 0.01, pct, st.y) -
		   smoothstep(pct, pct + 0.01, st.y);
}

void fragment() {
	float x = UV.x;
	float y = fract(sin(x)*10.0);
	vec3 color = vec3(y);
	
	//Line
	float pct = plot(UV, y);
	color = (1.0-pct)*color+pct*vec3(0.0,0.0,1.0);
    ALBEDO = vec3(color);
}
