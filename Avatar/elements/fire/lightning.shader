shader_type canvas_item;

uniform float uv_multiplier = 5.0;
uniform int lightning_number = 2;

// Plot function
float plot(vec2 st, float pct, float half_width){
  return  smoothstep( pct-half_width, pct, st.y) -
          smoothstep( pct, pct+half_width, st.y);
}

// Rand, noise, and fbm function
float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n), f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}

float fbm(vec2 n) {
    float total = 0.0, amplitude = 1.0;
    for (int i = 0; i < 7; i++) {
        total += noise(n) * amplitude;
        n += n;
        amplitude *= 0.5;
    }
    return total;
}

void fragment(){
	vec2 uv = UV*vec2(uv_multiplier, 1.0);
	vec4 color = vec4(0.0, 0.0, 0.0, 0.0);
	
	// Add lightning
	for ( int i = 0; i < lightning_number; i++){
		vec2 t = uv * vec2(2.0,1.0) + vec2(float(i), -float(i)) - TIME*6.0;
		float y = fbm(t)*0.5;
		float pct = plot(uv, y, 0.03);
		float buffer = plot(uv, y, 0.08);
	
		color += pct*vec4(0.6, 0.9, 1.0, 1.0);
		color += buffer*vec4(0.4, 0.9, 1.0, 0.0);
	}
	
	COLOR = color;
}