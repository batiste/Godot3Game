shader_type canvas_item;

uniform float limit = 0.16;
uniform float multColor = 1.1;
uniform sampler2D waveTexture: hint_black;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 colorUp = color * multColor;
	bool transparentWater = color.a < 0.98;
	bool isWater = color.b > 0.380 && color.b < 0.385;
	
	COLOR = color;
	
	if (transparentWater) {
		float mult2 = (6.0 + cos(TIME)) / 6.0;
		COLOR = vec4(0.2, 0.4, 0.8, 1.0) * mult2;
	}
	
	if (isWater) {
		vec2 translate = vec2(1.0, 1.0) * TIME / 10.0;
		vec4 sample = texture(waveTexture, UV * 10.0 + translate);
		
		float limitM = cos(TIME) / 25.0;

		if(sample.y - limitM > 1.0 - limit - 0.1) {
			COLOR = colorUp;
		}
		if(sample.y - limitM > 1.0 - limit) {
			COLOR = colorUp * multColor;
		}
	}
}