#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

// 3D Gradient noise from: https://www.shadertoy.com/view/Xsl3Dl
vec3 hash(vec3 p)
{
	p = vec3(dot(p, vec3(127.1, 311.7, 74.7)),
	         dot(p, vec3(269.5, 183.3, 246.1)),
	         dot(p, vec3(113.5, 271.9, 124.6)));

	return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

float noise(in vec3 p)
{
	vec3 i = floor(p);
	vec3 f = fract(p);

	vec3 u = f * f * (3.0 - 2.0 * f);

	return mix(mix(mix(dot(hash(i + vec3(0.0, 0.0, 0.0)), f - vec3(0.0, 0.0, 0.0)),
	                   dot(hash(i + vec3(1.0, 0.0, 0.0)), f - vec3(1.0, 0.0, 0.0)), u.x),
	               mix(dot(hash(i + vec3(0.0, 1.0, 0.0)), f - vec3(0.0, 1.0, 0.0)),
	                   dot(hash(i + vec3(1.0, 1.0, 0.0)), f - vec3(1.0, 1.0, 0.0)), u.x), u.y),
	           mix(mix(dot(hash(i + vec3(0.0, 0.0, 1.0)), f - vec3(0.0, 0.0, 1.0)),
	                   dot(hash(i + vec3(1.0, 0.0, 1.0)), f - vec3(1.0, 0.0, 1.0)), u.x),
	               mix(dot(hash(i + vec3(0.0, 1.0, 1.0)), f - vec3(0.0, 1.0, 1.0)),
	                   dot(hash(i + vec3(1.0, 1.0, 1.0)), f - vec3(1.0, 1.0, 1.0)), u.x), u.y), u.z);
}

void mainImage()
{
	vec2 starUv = fragCoord / iResolution.xy;

	vec3 stars_direction = normalize(vec3(starUv * 2.0 - 1.0, 1.0));
	float stars_threshold = 8.0;
	float stars_exposure = 200.0;
	float stars = pow(clamp(noise(stars_direction * 200.0), 0.0, 1.0), stars_threshold) * stars_exposure;
	stars *= mix(0.4, 1.4, noise(stars_direction * 100.0 + vec3(iTime)));

	fragColor = vec4(vec3(stars), 1.0);
}
