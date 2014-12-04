#import "MainScene.h"
#import "CCEffectScanline.h"

typedef NS_ENUM(NSUInteger, CCRetroScale) {
    CCRetroScaleFitWidth,
    CCRetroScaleFitHeight,
    CCRetroScaleFitScreen,
    CCRetroScaleFillScreen
};

@implementation MainScene {
    CCEffectNode* _effectNode;
}

- (void)didLoadFromCCB {
    
    // Scale To Fit Width
    [self setRetroScale:CCRetroScaleFitWidth];

    // Disable Anti-Alias Character Sprite Sheet, Be nice to set this on a sheet basis in SB
    CCTexture* animationTex = [CCTexture textureWithFile:@"animation.png"];
    [animationTex setAntialiased:NO];
    
    // Smoother
    [[_effectNode texture] setAntialiased:YES];
    
    // Input
    self.userInteractionEnabled = YES;
    
    //[_effectNode setEffect:[[CCEffectScanline alloc] init]];
}

- (void) setRetroScale:(CCRetroScale) retroScale {
    
    // Design Resolution
    CGSize designSize = _effectNode.contentSizeInPoints;
    
    // Device Resolution
    CGSize deviceSize = [CCDirector sharedDirector].viewSize;
    
    float scale = 1.0;
    
    switch (retroScale) {
        case CCRetroScaleFitWidth:
            scale  = deviceSize.width/designSize.width;
            break;
        case CCRetroScaleFitHeight:
            scale  = deviceSize.height/designSize.height;
            break;
        case CCRetroScaleFitScreen:
            scale  = MIN(deviceSize.width/designSize.width,deviceSize.height/designSize.height);
            break;
        case CCRetroScaleFillScreen:
            scale  = MAX(deviceSize.width/designSize.width,deviceSize.height/designSize.height);
            break;
        default:
            break;
    }
    
    // Scale Node
    [_effectNode setScaleX:scale];
    [_effectNode setScaleY:scale];
    
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
