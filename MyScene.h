//
//  MyScene.h
//  HanYu4u
//

//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Intro_Controller.h"


@class Intro_Controller; 

@interface MyScene : SKScene
@property (nonatomic, weak) Intro_Controller *introViewController;
@property (nonatomic, weak) SKLabelNode *switch_controllers;

@end
