//
//  GameLayer.m
//  pixelart
//
//  Created by Martin Walsh on 04/12/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer {
    CCTiledMap* _tileMap;
}

- (void)didLoadFromCCB {
    
    // Load TMX
    _tileMap = [CCTiledMap tiledMapWithFile:@"tilemap.tmx"];
    [self addChild:_tileMap z:-1];
    
    CCLOG(@"TMX Size: %f,%f",_tileMap.contentSizeInPoints.width,_tileMap.contentSizeInPoints.height);
    
    // Animate Map - Scroll around boundries
    CCActionMoveBy* moveActionX = [CCActionMoveBy actionWithDuration:2.0 position:ccp(self.parent.contentSizeInPoints.width-_tileMap.contentSizeInPoints.width,0)];
    CCActionMoveBy* moveActionY = [CCActionMoveBy actionWithDuration:2.0 position:ccp(0,self.parent.contentSizeInPoints.height-_tileMap.contentSizeInPoints.height)];
    
    CCActionSequence* moveSequence = [CCActionSequence actions:moveActionX,moveActionY,[moveActionX reverse],[moveActionY reverse],nil];

    // Animate Layer
    [self runAction:[CCActionRepeatForever actionWithAction:moveSequence]];

}

@end
