varying vec3 vPosition;
varying vec3 vNormal;

uniform float uTime;

#include ../includes/random2D.glsl

void main() {
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // Glitch
    float glitchTime = uTime - modelPosition.y;
    float glitchStrength = sin(glitchTime) + sin(glitchTime * 3.45) +  sin(glitchTime * 8.76);
    glitchStrength /= 5.0;
    glitchStrength = smoothstep(0.3, 1.0, glitchStrength);
    glitchStrength *= 0.15;
    modelPosition.x += (random2D(modelPosition.xz + uTime) - 0.5) * glitchStrength;
    modelPosition.z += (random2D(modelPosition.zx + uTime) - 0.5) * glitchStrength;

    // Model Normal
    vec4 modelNormal = modelMatrix * vec4(normal, 0.0);

    // Final Position
    gl_Position = projectionMatrix * viewMatrix * modelPosition;

    // Varyings
    vPosition = modelPosition.xyz;
    vNormal = modelNormal.xyz;
}
