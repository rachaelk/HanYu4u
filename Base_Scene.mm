//
//  Base_Scene.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/19/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "Base_Scene.h"
#import "Level0.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"
#import "Level10.h"
#import "Level11.h"
#import "Level13.h"
#import "SmallStore.h"
#import "MarketPlace.h"

@implementation Base_Scene

//@synthesize baseViewController = _baseViewController;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        //SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"chinaPretty_background"];
        //[sn setScale:SKSceneScaleModeAspectFill * 0.6];
        //sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        //sn.name = @"BACKGROUND";
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        SKLabelNode *small_store_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *marketplace_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];

        ///[self addChild:sn];
        SKLabelNode *level0_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level1_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level2_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level3_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level10_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level11_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level16_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level13_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
       /* SKLabelNode *level20_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level21_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level22_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        SKLabelNode *level23_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        */
        
               //level 0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        level0_label.text = @"~*activities*~"; //kanshu tingyinyue
        level0_label.fontSize = 16;
        level0_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level0_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level0_label.position = CGPointMake(0.5*(CGRectGetMinX(self.frame)+CGRectGetMidX(self.frame)),
                                            0.5*(CGRectGetMaxY(self.frame)+CGRectGetMidY(self.frame)));
        level0_label.name = @"level0_label";
        

        level1_label.text = @"~*hobbies*~"; //xihuan kanshu, xihuan tingyinyue
        level1_label.fontSize = 16;
        level1_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level1_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level1_label.position = CGPointMake(level0_label.position.x-1,
                                      level0_label.position.y-30);
        level1_label.name = @"level1_label";
        
        level3_label.text = @"~*numbers*~";//mingr, zuotian wanshang, dengdeng
        level3_label.fontSize = 16;
        level3_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level3_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level3_label.position = CGPointMake(level1_label.position.x,
                                            level1_label.position.y-30);
        level3_label.name = @"level3_label";
        
        level2_label.text = @"~*adjectives*~"; //lei, gui, pianyi, hao
        level2_label.fontSize = 16;
        level2_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level2_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level2_label.position = CGPointMake(level3_label.position.x+1,
                                            level3_label.position.y-30);
        level2_label.name = @"level2_label";
        
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~past level 0
        
        //level 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        level10_label.text = @"~*time of day*~";//ge, ben, zhang, zhi
        level10_label.fontSize = 16;
        level10_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level10_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level10_label.position = CGPointMake(level2_label.position.x+1,
                                             level2_label.position.y-30);
        level10_label.name = @"level10_label";
        
        level11_label.text = @"~*measure words*~";  //yi, er, san
        level11_label.fontSize = 16;
        level11_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level11_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level11_label.position = CGPointMake(level10_label.position.x,
                                            level10_label.position.y-30);
        level11_label.name = @"level11_label";
        /*
        level16_label.text = @"Level 1.6 -- actions completed"; //wo zuotian kanle san ben shu
        level16_label.fontSize = 16;
        level16_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level16_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level16_label.position = CGPointMake(level11_label.position.x+1,
                                            level11_label.position.y-30);
        level16_label.name = @"level16_label";
        */
        level13_label.text = @"~*time*~";//yidiar cai,na xie shu, zhe xie dongxi, zhe zhi bi
        level13_label.fontSize = 16;
        level13_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level13_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level13_label.position = CGPointMake(level11_label.position.x,
                                            level11_label.position.y-30);
        level13_label.name = @"level13_label";
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~past level 1
        //FUTURE:
        /*
        //level 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        level20_label.text = @"Level 2.0 -- questions"; // ni yao zhege ma?
        level20_label.fontSize = 16;
        level20_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level20_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level20_label.position = CGPointMake(CGRectGetMinX(self.frame)+30,
                                             CGRectGetMaxY(self.frame)-10);
        level20_label.name = @"level20_label";
        
        level21_label.text = @"Level 2.3 -- adjectives and amounts"; //ni you yidianer lei ma?
        level21_label.fontSize = 16;
        level21_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level21_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level21_label.position = CGPointMake(level0_label.position.x-1,
                                             level0_label.position.y-30);
        level21_label.name = @"level21_label";
        
        level22_label.text = @"Level 2.6 -- do more of something"; //duo kanshu, duo xuexi, shao xuexi
        level22_label.fontSize = 16;
        level22_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level22_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level22_label.position = CGPointMake(level1_label.position.x+1,
                                             level1_label.position.y-30);
        level22_label.name = @"level22_label";
        
        level23_label.text = @"Level 2.9 -- modify the adj"; //pianyi yidianer
        level23_label.fontSize = 16;
        level23_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        level23_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level23_label.position = CGPointMake(level2_label.position.x,
                                             level2_label.position.y-30);
        level23_label.name = @"level23_label";
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~past level 2
        */
        
        small_store_label.text = @"   小店 ";
        small_store_label.fontSize = 16;
        small_store_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        small_store_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        small_store_label.position = CGPointMake(level13_label.position.x,
                                                 level13_label.position.y - 30);
        small_store_label.name = @"small_store_label";
        
        marketplace_label.text = @"  大商场 ";
        marketplace_label.fontSize = 16;
        marketplace_label.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        marketplace_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        marketplace_label.position = CGPointMake(small_store_label.position.x,
                                                 small_store_label.position.y - 30);
        marketplace_label.name = @"marketplace_label";
        

        SKSpriteNode *geek_man = [SKSpriteNode spriteNodeWithImageNamed:@"geekWin_man"];
        geek_man.position = CGPointMake(CGRectGetMaxX(self.frame)-50, CGRectGetMinY(self.frame)+50);
        [geek_man setScale:0.5];
        
     
        
   
        [self addChild:marketplace_label];
        [self addChild:small_store_label];
        [self addChild:level0_label];
        [self addChild:level1_label];
        [self addChild:level2_label];
        [self addChild:level3_label];
        [self addChild:level10_label];
        [self addChild:level11_label];
        [self addChild:level16_label];
        [self addChild:level13_label];
        [self addChild:geek_man];

    }
    return self;
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        for (SKNode *node in nodes) {
           
            
            
            if ([node.name isEqualToString:@"level0_label"]) {
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;                
                Level0 *newScene = [Level0 sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            
            
            if ([node.name isEqualToString:@"small_store_label"]) {
                
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;
                SmallStore *newScene = [SmallStore sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            
            if ([node.name isEqualToString:@"marketplace_label"]) {
                
                for (UIView *subview in [self.view subviews]) {
                    
                    [subview removeFromSuperview];
                   
                }
                SKView *spriteView = (SKView *) self.view;
                MarketPlace *newScene = [MarketPlace sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            
            
            
            if ([node.name isEqualToString:@"level1_label"]) {
                NSLog(@"level1");
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;
                Level1 *newScene = [Level1 sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            
            if ([node.name isEqualToString:@"level2_label"]) {
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;
                Level2 *newScene = [Level2 sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            
            if ([node.name isEqualToString:@"level3_label"]) {
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;
                Level3 *newScene = [Level3 sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            if ([node.name isEqualToString:@"level10_label"]) {
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;
                Level11 *newScene = [Level11 sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            if ([node.name isEqualToString:@"level11_label"]) {
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;
                Level10 *newScene = [Level10 sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            
            if ([node.name isEqualToString:@"level13_label"]) {
                for (UIView *subview in [self.view subviews]) {
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                SKView *spriteView = (SKView *) self.view;
                Level13 *newScene = [Level13 sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
            }
            
            
        }
    }
    
    

}




-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
