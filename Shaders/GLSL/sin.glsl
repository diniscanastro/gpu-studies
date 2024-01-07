#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

void main() {
	vec2 pixel_position = gl_FragCoord.xy/u_resolution; // Divide the coordinates by the total resolution to get a value between 0 and 1.

  float y = (sin(pixel_position.x * 2.0 * PI) + 1.0) / 2.0 ;

  vec3 color = vec3(y); // Create a vector with all values equal to the y value

  // Plot a line
  float pct = plot(pixel_position,y);
  color = (1.0 - pct) * color + pct * vec3(0.0,1.0,0.0); // Decides whether to use the plot or the exysting Y gradient for the color

	gl_FragColor = vec4(color,1.0);

}