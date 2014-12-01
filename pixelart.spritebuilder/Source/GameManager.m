//
//  GameManager.m
//  retroeffect
//
//  Created by Martin Walsh on 28/11/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager : NSObject

+(GameManager*)sharedManager {
    static GameManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

@end