#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 rectangle(vec2 bl, 
                vec2 tl, 
                vec2 st, 
                vec3 color,
                vec3 bg_color){
    // bottom-left
    vec2 pc = step(bl,st);
    pc *= step(tl, 1.0 - st);
    return (pc.x * pc.y) * color + (1.0 - pc.x * pc.y) * bg_color;
}

vec3 circle(vec2 center,
            float radius,
            vec2 st,
            vec3 color,
            vec3 bg_color){
                float dist = distance(st,center);
                float pc = 1.0 - step(radius, dist);
                return pc * color + (1.0 - pc) * bg_color;
            }

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(1.0, 1.0, 1.0);

    // Colored squares
    color = rectangle(
        vec2(0.0, 0.0), 
        vec2(0.8, 0.8), 
        st, 
        vec3(0.0196, 0.3373, 0.8863),
        color
    );

    color = rectangle(
        vec2(0.2, 0.2), 
        vec2(0.0, 0.0), 
        st, 
        vec3(0.9412, 0.0353, 0.2157),
        color
    );

    color = rectangle(
        vec2(0.9, 0.0), 
        vec2(0.0, 0.9), 
        st, 
        vec3(0.9255, 0.9412, 0.0353),
        color
    );

    color = circle(
        vec2(0.6, 0.2),
        0.3,
        st,
        vec3(0.6, 0.6, 0.6),
        color
    );

    color = circle(
        vec2(0.2, 0.8),
        0.1,
        st,
        vec3(0.0275, 0.9647, 0.4196),
        color
    );

    gl_FragColor = vec4(color,1.0);
}