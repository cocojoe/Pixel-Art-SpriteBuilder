//
//  CCEffectScanline.m
//  pixelart
//
//  Created by Martin Walsh on 01/12/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCEffectScanline.h"
#import "CCEffect_Private.h"
#import "CCRenderer.h"
#import "CCTexture.h"


@implementation CCEffectScanline

-(id)init
{
    return [self initWithScanline];
}

-(id)initWithScanline
{

    if((self = [super initWithFragmentUniforms:@[] vertexUniforms:nil varyings:nil]))
    {
        self.debugName = @"CCEffectScanline";
    }
    return self;
}

-(void)buildFragmentFunctions
{
    self.fragmentFunctions = [[NSMutableArray alloc] init];
    
    CCEffectFunctionInput *input = [[CCEffectFunctionInput alloc] initWithType:@"vec4" name:@"inputValue" initialSnippet:CCEffectDefaultInitialInputSnippet snippet:CCEffectDefaultInputSnippet];

    // Try using a texture, doesn't work well depending on scale
    NSString* effectBody = CC_GLSL(
                                   float odd = floor(mod(gl_FragCoord.y, 2.0)) + 0.5;
                                   return vec4(inputValue.rgba*odd);
                                   );
    
    CCEffectFunction* fragmentFunction = [[CCEffectFunction alloc] initWithName:@"scanlineEffect" body:effectBody inputs:@[input] returnType:@"vec4"];
    
    [self.fragmentFunctions addObject:fragmentFunction];
}

-(void)buildRenderPasses
{

    CCEffectRenderPass *pass0 = [[CCEffectRenderPass alloc] init];
    
    pass0.debugLabel = @"CCEffectScanline pass 0";
    pass0.shader = self.shader;
    pass0.beginBlocks = @[[^(CCEffectRenderPass *pass, CCTexture *previousPassTexture){
        
        pass.shaderUniforms[CCShaderUniformMainTexture] = previousPassTexture;
        pass.shaderUniforms[CCShaderUniformPreviousPassTexture] = previousPassTexture;
        pass.shaderUniforms[CCShaderUniformTexCoord1Center] = [NSValue valueWithGLKVector2:pass.texCoord1Center];
        pass.shaderUniforms[CCShaderUniformTexCoord1Extents] = [NSValue valueWithGLKVector2:pass.texCoord1Extents];
    } copy]];
    
    self.renderPasses = @[pass0];
}


@end
