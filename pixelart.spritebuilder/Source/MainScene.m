#import "MainScene.h"
#import "CCEffectScanline.h"

@implementation MainScene {
    CCEffectNode* _effectNode;
}

- (void)didLoadFromCCB {
    
    // Design Resolution
    CGSize designSize = _effectNode.contentSizeInPoints;
    
    // Device Resolution
    CGSize deviceSize = [CCDirector sharedDirector].viewSize;
    
    // Auto Scale
    float scale  = deviceSize.width/designSize.width;

    [_effectNode setScaleX:scale];
    [_effectNode setScaleY:scale];
    
    // Disable Anti-Alias Character Sprite Sheet
    CCTexture* animationTex = [CCTexture textureWithFile:@"animation.png"];
    [animationTex setAntialiased:NO];
    
    // Smooth scrolling
    [[_effectNode texture] setAntialiased:YES];
    
    // Input
    self.userInteractionEnabled = YES;
    
    //[_effectNode setEffect:[[CCEffectScanline alloc] init]];
}

#if __CC_PLATFORM_MAC
- (void)mouseDown:(NSEvent *)theEvent {
    CGPoint pos = [theEvent locationInNode:_effectNode]; // Relative to Design
    [self touchActionBegin:pos];
}
- (void)mouseUp:(NSEvent *)theEvent {
    CGPoint pos = [theEvent locationInNode:_effectNode]; // Relative to Design
    [self touchActionEnd:pos];
}

#elif __CC_PLATFORM_IOS || __CC_PLATFORM_ANDROID
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint pos = [touch locationInNode:_effectNode]; // Relative to Design
    [self touchActionBegin:pos];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint pos = [touch locationInNode:_effectNode]; // Relative to Design
    [self touchActionEnd:pos];
}
#endif

- (void)touchActionBegin:(CGPoint) pos {
    CCLOG(@"Touch: %f,%f",pos.x,pos.y);
    [self setPaused:!self.paused];
}

- (void)touchActionEnd:(CGPoint) pos {
}

@end
