#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.0863, 0.4353, 0.7843);
vec3 colorB = vec3(0.8941, 0.6745, 0.2314);

float easeOutBounce(float x) {
  float n1 = 7.56;
  float d1 = 2.75;

  if (x < 1.0 / d1) {
      return n1 * x * x;
  } else if (x < 2.0 / d1) {
      return n1 * (x -= 1.5 / d1) * x + 0.75;
  } else if (x < 2.5 / d1) {
      return n1 * (x -= 2.25 / d1) * x + 0.9375;
  } else {
      return n1 * (x -= 2.625 / d1) * x + 0.984375;
  }
}

void main() {
    vec3 color = vec3(0.0);

    // Sin wave
    //float pct = abs(sin(u_time));
    float pct = easeOutBounce(u_time/5.0);

    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    color = mix(colorA, colorB, pct);

    gl_FragColor = vec4(color,1.0);
}