shader_type canvas_item;

uniform float limit = 0.16;
uniform float multColor = 1.3;
uniform sampler2D waveTexture: hint_black;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 colorUp = color * multColor;
	COLOR = color;
	if (color.a < 0.98) {
		float mult2 = (6.0 + cos(TIME)) / 6.0;
		COLOR = vec4(0.2, 0.4, 0.8, 1.0) * mult2;
	} else if (color.b > 0.380 && color.b < 0.385) {
		//		float size = float(textureSize(TEXTURE, 0).x);
		//		float sizeW = float(textureSize(waveTexture, 0).x);
		//		float ratio = sizeW / size;
		// COLOR = texture(waveTexture, UV * 24.0);
		vec2 translate = vec2(1.0, 1.0) * TIME / 4.0;
		vec4 sample = texture(waveTexture, UV * 10.0 + translate);

		float mask = step(sample.y, limit);
		if(mask > 0.9) {
			COLOR = colorUp;
		}
	} else {
		COLOR = color;
	}
	
	// float mask = step(sample.y, 0.5);
	// COLOR = vec4(0.0, 0.0, mask, 0.0);
	// COLOR = texture(TEXTURE, UV);
//	if (color.a < 0.98) {
//		float mult2 = (5.0 + cos(TIME * UV.x * speed * 50.0)) / 5.0;
//		COLOR = vec4(0.3, 0.5, 0.9, 1.0) * mult2;
//	} else if (color.b > 0.380 && color.b < 0.385) {
//		float sinWave = sin(TIME * speed);
//		float mult = (8.0 + sinWave) / 8.0;
//		vec4 colorBottom = texture(TEXTURE, UV + vec2(sinWave / 18.0, sinWave / 18.0));
//		if (colorBottom.a < 0.98) {
//			COLOR = vec4(0.7, 0.8, 1.0, 1.0);
//		} else {
//			COLOR = vec4(color.r * mult, color.g * mult, color.b * mult, 1.0);
//		}
//	} else {
//		COLOR = color;
//	}

}