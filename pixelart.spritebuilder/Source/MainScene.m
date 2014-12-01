#import "MainScene.h"
#import "CCEffectScanline.h"

@implementation MainScene {
    CCEffectNode* _effectNode;
}

- (void)didLoadFromCCB {
    //[_effectNode setEffect:[[CCEffectScanline alloc] init]];
    //[[_effectNode texture] setAntialiased:NO];
}

@end
