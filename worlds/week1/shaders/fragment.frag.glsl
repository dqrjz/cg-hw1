#version 300 es
precision highp float;

uniform float uTime;   // TIME, IN SECONDS
in vec3 vPos;     // -1 < vPos.x < +1
// -1 < vPos.y < +1
//      vPos.z == 0

out vec4 fragColor;

void main() {

  // HERE YOU CAN WRITE ANY CODE TO
  // DEFINE A COLOR FOR THIS FRAGMENT

  float rmax = 0.1;
  float k1 = 0.5 * (sqrt(rmax * rmax + 4. * rmax) - rmax);
  float k2 = 1. - 1. / k1;

  float rr = 0.7 / 2.;
  vec2 center = rr * vec2(cos(uTime), sin(uTime));

  vec2 cRed = center + rr * vec2(-cos(uTime), sin(uTime));
  float rRed = sqrt((vPos.x - cRed.x) * (vPos.x - cRed.x) +
            (vPos.y - cRed.y) * (vPos.y - cRed.y));
  float aRed = max(0., 1. / (rRed + k1) + k2);
  float red = aRed * cos(140. * rRed - 20. * uTime);

  vec2 cGreen = center + rr * vec2(cos(uTime), -sin(uTime));
  float rGreen = sqrt((vPos.x - cGreen.x) * (vPos.x - cGreen.x) +
            (vPos.y - cGreen.y) * (vPos.y - cGreen.y));
  float aGreen = max(0., 1. / (rGreen + k1) + k2);
  float green = aGreen * cos(140. * rGreen - 20. * uTime);

  vec2 cBlue = center + rr * vec2(sin(uTime), cos(uTime));
  float rBlue = sqrt((vPos.x - cBlue.x) * (vPos.x - cBlue.x) +
            (vPos.y - cBlue.y) * (vPos.y - cBlue.y));
  float aBlue = max(0., 1. / (rBlue + k1) + k2);
  float blue = aBlue * cos(140. * rBlue - 20. * uTime);

  vec2 cCyan = center + rr * vec2(-sin(uTime), -cos(uTime));
  float rCyan = sqrt((vPos.x - cCyan.x) * (vPos.x - cCyan.x) +
            (vPos.y - cCyan.y) * (vPos.y - cCyan.y));
  float aCyan = max(0., 1. / (rCyan + k1) + k2);
  float cyan = aCyan * cos(140. * rCyan - 20. * uTime);

  // R,G,B EACH RANGE FROM 0.0 TO 1.0
  vec3 color = vec3(red, green, blue) + vec3(0., cyan, cyan) + vec3(0.0001);

  // draw lines
  if (vPos.x > -0.002 && vPos.x < 0.001) {
    color += 0.5 * vec3(max(0., 0.5 * sin(0.5 * uTime)), 0., 0.);
  }
  if (vPos.x == vPos.y) {
    color += 0.5 * vec3(0., 0., max(0., 0.5 * sin(0.5 * uTime)));
  }
  if (vPos.y > -0.002 && vPos.y < 0.001) {
    color += 0.5 * vec3(0., max(0., 0.5 * sin(0.5 * uTime)), 0.);
  }
  if (vPos.x + vPos.y > -0.002 && vPos.x + vPos.y < 0.001) {
    color += 0.5 * vec3(0., max(0., 0.5 * sin(0.5 * uTime)), max(0., 0.5 * sin(0.5 * uTime)));
  }
  if (sqrt(vPos.x * vPos.x + vPos.y * vPos.y) > 0.796 &&
      sqrt(vPos.x * vPos.x + vPos.y * vPos.y) < 0.804) {
    color += 0.05 * vec3(1., 1., 1.) * -min(0., 0.5 * sin(0.5 * uTime));
  }

  // THIS LINE OUTPUTS THE FRAGMENT COLOR
  fragColor = vec4(sqrt(color), 1.0);
}
