//
//  GameState.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/20/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "GameState.h"

@implementation GameState

@synthesize keyboard_characters;
@synthesize keyboard_characters_shift;
@synthesize keyboard_characters_alt;


+ (instancetype)sharedInstance
{
    static dispatch_once_t pred = 0;
    static GameState *_sharedInstance = nil;
    
    dispatch_once( &pred, ^{
        _sharedInstance = [[super alloc] init];
        
    });
    return _sharedInstance;
}
- (id) init
{
    if (self = [super init]) {
        // Init
        _score = 0;
        _level_mod = 0;
        _grocery_items = 0;
        
        
        // Load game state
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        id score = [defaults objectForKey:@"score"];
        if (score) {
            _score = [score intValue];
        }
        id grocery_items = [defaults objectForKey:@"grocery_items"];
        if (grocery_items) {
            _grocery_items = [grocery_items intValue];
        }
        int n = 0;
        while(_grocery_items > n*20 ){
            n = n+1;
            
        }
        _level_mod = n*0.5;
        

    }
    return self;
}

- (void) saveState
{
    // Update highScore if the current score is greater
    
    
    // Store in user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:_score] forKey:@"score"];
    [defaults setObject:[NSNumber numberWithInt:_grocery_items] forKey:@"grocery_items"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
