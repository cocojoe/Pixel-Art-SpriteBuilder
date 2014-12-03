#import "MainScene.h"
#import "CCEffectScanline.h"

@implementation MainScene {
    CCEffectNode* _effectNode;
    CCTiledMap* _tileMap;
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
    
    // Load TMX
    _tileMap = [CCTiledMap tiledMapWithFile:@"tilemap.tmx"];
    [_effectNode addChild:_tileMap z:-5];
    
    // Quick Texture Alias Testing
    CCTexture* animationTex = [CCTexture textureWithFile:@"animation.png"];
    [animationTex setAntialiased:NO];
    
    // Doesn't seem to work however scrolling does feel smoother in Simulator
    [[_effectNode texture] setAntialiased:YES];
    
    // Input
    self.userInteractionEnabled = YES;
    
    // Animate Map
    CCActionMoveBy* moveActionX = [CCActionMoveBy actionWithDuration:2.0 position:ccp(designSize.width-_tileMap.contentSizeInPoints.width,0)];
    CCActionMoveBy* moveActionY = [CCActionMoveBy actionWithDuration:2.0 position:ccp(0,designSize.height-_tileMap.contentSizeInPoints.height)];
    
    CCActionSequence* moveSequence = [CCActionSequence actions:moveActionX,moveActionY,[moveActionX reverse],[moveActionY reverse],nil];
    moveSequence.tag = 1;
    
    [_tileMap runAction:[CCActionRepeatForever actionWithAction:moveSequence]];
    
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

- (void) update:(CCTime)delta {
}

@end
