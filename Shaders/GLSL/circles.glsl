#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution;
    float dist = 0.0;
    float pct = 0.0;
    
    vec2 center = vec2(0.2, 0.2);
    float radius = 0.1;

    dist = distance(st,center);
    pct = step(radius, dist);
    
    vec3 color = vec3(pct);

	gl_FragColor = vec4( color, 1.0 );
}
