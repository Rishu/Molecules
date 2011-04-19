//
//  Shader.vsh
//  CubeExample
//
//  Created by Brad Larson on 4/20/2010.
//

attribute mediump vec4 position;
attribute mediump vec2 inputImpostorSpaceCoordinate;
attribute mediump vec2 ambientOcclusionTextureOffset;

varying mediump vec2 impostorSpaceCoordinate;
varying mediump vec3 normalizedViewCoordinate;
varying mediump vec2 depthLookupCoordinate;
varying mediump vec2 ambientOcclusionTextureBase;
varying mediump float depthAdjustmentForOrthographicProjection;

uniform mediump mat4 modelViewProjMatrix;
uniform mediump mat4 orthographicMatrix;
uniform mediump float sphereRadius;

void main()
{
    ambientOcclusionTextureBase = (ambientOcclusionTextureOffset + 1.0 / 1024.0);
    
    vec4 transformedPosition;
	transformedPosition = modelViewProjMatrix * position;
    impostorSpaceCoordinate = inputImpostorSpaceCoordinate.xy;
    depthLookupCoordinate = (inputImpostorSpaceCoordinate + 1.0) / 2.0;

    transformedPosition.xy = transformedPosition.xy + inputImpostorSpaceCoordinate.xy * vec2(sphereRadius);
    transformedPosition = transformedPosition * orthographicMatrix;
    
    depthAdjustmentForOrthographicProjection = (vec4(0.0, 0.0, 1.0, 0.0) * orthographicMatrix).z;

    normalizedViewCoordinate = (transformedPosition.xyz + 1.0) / 2.0;
    gl_Position = transformedPosition;
}
