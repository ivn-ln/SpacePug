/* -----------------
X-ray shader by Michael Watt
Thanks to KubikPixel for the SciFi Hologram shader on which much of this code is based, and GDQuest for the demo scene I used for troubleshooting.

This is the consolidation of the x-ray shaders shown in the video:
	https://youtu.be/seIYhuF6Tdk

Please note that this shader is designed for experimentation, and is 
therefore not optimized for performance.

MIT License
----------------- */ 

shader_type spatial;
render_mode unshaded, depth_test_disabled;

// Options for testing different effects
uniform bool enable_glow = false;
uniform bool enable_lines = false;
uniform bool enable_flicker = false;
uniform bool enable_pattern = false;

// Used for Magic and SciFi effects
uniform mediump vec4 base_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform mediump vec4 glow_color : source_color = vec4(0.5, 0.75, 1.0, 1.0);
uniform lowp float glow_itensity : hint_range(0, 20) = 4.5;
uniform lowp float glow_amount : hint_range(0, 20) = 4.5;

// Used for SciFi effect
uniform lowp float flickering : hint_range(0, 1) = 0.55;
uniform sampler2D static_texture;
uniform mediump float line_width : hint_range(0, 1) = 0.005;
uniform mediump float line_blur : hint_range(0, 1) = 0.2;
uniform mediump float line_speed : hint_range(-1, 1) = 0.02;
uniform  bool straight_lines = true;
uniform mediump float interrupt_width : hint_range(0, 1) = 0.5;
uniform mediump float interrupt_blur : hint_range(0, 1) = 0.25;
uniform mediump float interrupt_speed : hint_range(-1, 1) = 0.2;

// Used for Pattern effect
uniform sampler2D pattern_texture;

//Note: higher amount values result in a thinner line
vec3 fresnel_glow(float amount, float intensity, vec3 color, vec3 normal, vec3 view) {
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}

void fragment () {
	vec2 canvas;
	if (straight_lines) {
			canvas = SCREEN_UV;
	} else {
		canvas = vec2(VIEW.x, VIEW.y);
	}
	vec2 lines = vec2(clamp(sin((TIME * line_speed + canvas.y) / line_width), line_blur, 1.0 - line_blur), canvas.x);
	vec2 interupts = vec2(clamp(sin((TIME * interrupt_speed + canvas.y) / interrupt_width * 3.0), interrupt_blur, 1.0 - interrupt_blur), canvas.x);
	
	float flicker;
	if (enable_flicker){
		flicker = clamp(fract(cos(TIME) * 43758.5453123), flickering, 1.0);
	} else {
		flicker = 1.0;
	}
	
	vec4 imgtex;
	if(enable_pattern) {
		imgtex = texture(pattern_texture, SCREEN_UV);
	} else {
		imgtex = base_color;
	}
	
	imgtex *= flicker * texture(static_texture, lines * interupts);
	vec3 imgtex_color = vec3(imgtex.r, imgtex.g, imgtex.b);
	
	ALBEDO = imgtex_color;
	
	if(enable_glow)
	{
		vec3 fresnel_color = vec3(glow_color.r, glow_color.g, glow_color.b);
		vec3 fresnel = fresnel_glow(glow_amount, glow_itensity, fresnel_color, NORMAL, VIEW);
		ALBEDO += fresnel;
	}
	
	EMISSION = glow_amount * vec3(glow_color.r, glow_color.g, glow_color.b);
	
	if(enable_lines)
		ALPHA = lines.x * interupts.x;
}