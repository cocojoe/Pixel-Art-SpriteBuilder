#import "MainScene.h"
#import "CCEffectScanline.h"

@implementation MainScene {
    CCEffectNode* _effectNode;
}

- (void)didLoadFromCCB {
    
    // Design Resolution
    CGSize designSize = CGSizeMake(400.0, 240.0);
    
    // Device Resolution
    CGSize deviceSize = [CCDirector sharedDirector].viewSize;
    
    // Auto Scale
    float scale  = deviceSize.width/designSize.width;

    [_effectNode setScaleX:scale];
    [_effectNode setScaleY:scale];
    
    [_effectNode setEffect:[[CCEffectScanline alloc] init]];
    [[_effectNode texture] setAntialiased:NO];
}

@end
