//
//  Level10.h
//  HanYu4u
//
//  Created by Rachael Keller on 8/9/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Level10 : SKScene

@property (nonatomic, weak) SKLabelNode *lblScore;
@property (nonatomic, weak) SKLabelNode *dialog_start10;
@property (nonatomic, weak) SKLabelNode *go_back;
@property (nonatomic, weak) SKLabelNode *change_page;


@property (nonatomic, weak) SKLabelNode *sentence1a;
@property (nonatomic, weak) SKLabelNode *sentence1b;
@property (nonatomic, weak) SKLabelNode *sentence1c;
@property (nonatomic, weak) SKLabelNode *sentence1d;
@property (nonatomic, weak) SKLabelNode *sentence2a;
@property (nonatomic, weak) SKLabelNode *sentence2b;
@property (nonatomic, weak) SKLabelNode *sentence2c;
@property (nonatomic, weak) SKLabelNode *sentence2d;
@property (nonatomic, weak) SKLabelNode *sentence3a;
@property (nonatomic, weak) SKLabelNode *sentence3b;
@property (nonatomic, weak) SKLabelNode *sentence3c;
@property (nonatomic, weak) SKLabelNode *sentence3d;
@property (nonatomic, weak) SKLabelNode *sentence4a;
@property (nonatomic, weak) SKLabelNode *sentence4b;
@property (nonatomic, weak) SKLabelNode *sentence4c;
@property (nonatomic, weak) SKLabelNode *sentence4d;
@property (nonatomic, weak) SKLabelNode *sentence5a;
@property (nonatomic, weak) SKLabelNode *sentence5b;
@property (nonatomic, weak) SKLabelNode *sentence5c;

@property (nonatomic, weak) SKLabelNode *sentence6a;
@property (nonatomic, weak) SKLabelNode *sentence6b;
@property (nonatomic, weak) SKLabelNode *sentence6c;

@property (nonatomic, weak) SKLabelNode *sentence7a;
@property (nonatomic, weak) SKLabelNode *sentence7b;
@property (nonatomic, weak) SKLabelNode *sentence7c;

@property (nonatomic, weak) SKLabelNode *sentence8a;
@property (nonatomic, weak) SKLabelNode *sentence8b;
@property (nonatomic, weak) SKLabelNode *sentence8c;



-(void)show_chinese_translation:(NSString*)chinese_character pinyin:(NSString*)pinyin english:(NSString*)english touch_loc:(CGPoint)touchLocationInView;
@end