//
//  GameState.h
//  HanYu4u
//
//  Created by Rachael Keller on 7/20/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameState : NSObject
@property (nonatomic, assign) int score;
@property (nonatomic, assign) int level_mod;
@property (nonatomic, assign) int grocery_items;
@property (nonatomic, retain) NSMutableArray* keyboard_characters;
@property (nonatomic, retain) NSMutableArray* keyboard_characters_shift;
@property (nonatomic, retain) NSMutableArray* keyboard_characters_alt;

+ (instancetype)sharedInstance;
- (void) saveState;
@end
