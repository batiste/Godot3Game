shader_type canvas_item;

uniform float speed = 0.5;
uniform sampler2D waveTexture: hint_black;

void fragment() {
	float size = float(textureSize(TEXTURE, 0).x);
	vec4 color = texture(TEXTURE, UV);
	if (color.a < 0.98) {
		float mult2 = (5.0 + cos(TIME * UV.x * speed * 50.0)) / 5.0;
		COLOR = vec4(0.3, 0.5, 0.9, 1.0) * mult2;
	} else if (color.b > 0.380 && color.b < 0.385) {
		float sinWave = sin(TIME * speed);
		float mult = (8.0 + sinWave) / 8.0;
		vec4 colorBottom = texture(TEXTURE, UV + vec2(sinWave / 18.0, sinWave / 18.0));
		if (colorBottom.a < 0.98) {
			COLOR = vec4(0.7, 0.8, 1.0, 1.0);
		} else {
			COLOR = vec4(color.r * mult, color.g * mult, color.b * mult, 1.0);
		}
	} else {
		COLOR = color;
	}

}