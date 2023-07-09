shader_type canvas_item;

uniform float glow_size = 1.0;
uniform vec4 glow_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    vec2 size = vec2(glow_size) / SCREEN_PIXEL_SIZE;
    vec4 glow = vec4(0.0);
    for(float x = -1.0; x <= 1.0; x++) {
        for(float y = -1.0; y <= 1.0; y++) {
            vec2 offset = vec2(x, y) * size;
            glow += textureLod(SCREEN_TEXTURE, SCREEN_UV + offset, 0.0);
        }
    }
    glow /= 9.0;
    color.rgb = mix(color.rgb, glow_color.rgb, glow_color.a * glow.a);
    COLOR = color;
}