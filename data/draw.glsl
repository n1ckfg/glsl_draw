uniform vec3 iResolution;
uniform float iGlobalTime;
uniform vec4 iMouse;

uniform sampler2D tex0;

float distanceToSegment(vec2 a, vec2 b, vec2 p) {
	vec2 pa = p - a, ba = b - a;
	float h = clamp(dot(pa,ba) / dot(ba,ba), 0.0, 1.0);
	return length(pa - ba * h) * 0.01;
}

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.y -= rand(uv) * 0.01;
	vec2 p = fragCoord.xy / iResolution.xx;
    vec4 m = iMouse / iResolution.xxxx;

	vec3 col = texture2D(tex0, uv).xyz;

	if (m.z > 0.0) {
		float d = distanceToSegment(m.xy, m.zw, p);
        col = mix(col, vec3(0.1,0.2,0.1), 1.0-smoothstep(0.002,0.004, d)) * rand(col.xy);
	}

	col = mix(col, vec3(sin(iGlobalTime * 100), 0.4, 0.51), 1.0 - smoothstep(0.001, 0.025, length(p - m.xy)));

	fragColor = vec4(col, 1.0);
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}