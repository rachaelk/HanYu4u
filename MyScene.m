//
//  MyScene.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/18/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "MyScene.h"



@implementation MyScene

@synthesize introViewController = _introViewController;
@synthesize switch_controllers = _switch_controllers;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        
        myLabel.text = @"HanYu4u ~ 汉语4u!";
        myLabel.fontSize = 30;
        myLabel.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        SKLabelNode *myIntroLabel = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *myIntroLabel_eng = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    
             
        SKSpriteNode *button = [SKSpriteNode spriteNodeWithImageNamed:@"return"];
        [button setScale:0.6];
        button.alpha = 0.9;
        
        button.position = CGPointMake(CGRectGetMinX(self.frame)+30, CGRectGetMinY(self.frame)+30);
        
        
        
        _switch_controllers = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _switch_controllers.text = @"开始!";
        _switch_controllers.fontColor = [SKColor colorWithRed:1 green:0 blue:0.2 alpha:1];
        _switch_controllers.fontSize = 14;
        _switch_controllers.zPosition = 1;
        _switch_controllers.position = CGPointMake( (button.position.x ),0.5*(button.position.y + button.size.height));
        
        _switch_controllers.name = @"_switch_controllers";
        
        
        SKSpriteNode *intro_man = [SKSpriteNode spriteNodeWithImageNamed:@"cereal_man"];
        intro_man.position = CGPointMake(CGRectGetMaxX(self.frame)-50, CGRectGetMinY(self.frame)+50);
        [intro_man setScale:0.5];

        myIntroLabel.text = @"嘿，你为什么不在学汉语呢？";
        myIntroLabel.fontSize = 18;
        
        myIntroLabel.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0.1 alpha:1.0];
        myIntroLabel.position = CGPointMake((intro_man.position.x - CGRectGetMinX(self.frame))/2,  (intro_man.position.y + myLabel.position.y)*0.45);

        myIntroLabel_eng.text = @"Yo, the hell are you not studying Chinese?";
        myIntroLabel_eng.fontSize = 10;
        
        myIntroLabel_eng.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0.1 alpha:1.0];
        myIntroLabel_eng.position = CGPointMake((myIntroLabel.position.x),  (myIntroLabel.position.y -10));
        
        
 
        
        [self addChild:_switch_controllers];
        [self addChild:button];
        [self addChild:myLabel];
        [self addChild:intro_man];
        [self addChild:myIntroLabel];
        [self addChild:myIntroLabel_eng];
    }
    return self;
}



//works:
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {

        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        for (SKNode *node in nodes) {
            if ([node.name isEqualToString:@"_switch_controllers"]) {
                [self removeAllChildren];
               [_introViewController switchToSecondPage];
             }
        }
    }

}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
