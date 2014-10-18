//
//  Level0.h
//  HanYu4u
//
//  Created by Rachael Keller on 7/19/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Base_Storyboard.h"


@interface Level0 : SKScene

@property (nonatomic, weak) SKLabelNode *lblScore;
@property (nonatomic, weak) SKLabelNode *dialog_start00;
@property (nonatomic, weak) SKLabelNode *go_back;
@property (nonatomic, weak) SKLabelNode *change_page;

@property (nonatomic, weak) SKLabelNode *sentence1a;
@property (nonatomic, weak) SKLabelNode *sentence1b;
@property (nonatomic, weak) SKLabelNode *sentence1c;

@property (nonatomic, weak) SKLabelNode *sentence2a;
@property (nonatomic, weak) SKLabelNode *sentence2b;
@property (nonatomic, weak) SKLabelNode *sentence2c;

@property (nonatomic, weak) SKLabelNode *sentence3a;
@property (nonatomic, weak) SKLabelNode *sentence3b;
@property (nonatomic, weak) SKLabelNode *sentence3c;

@property (nonatomic, weak) SKLabelNode *sentence4a;
@property (nonatomic, weak) SKLabelNode *sentence4b;
@property (nonatomic, weak) SKLabelNode *sentence4c;

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

@property (nonatomic, weak) SKSpriteNode *book_man;
@property (nonatomic, weak) SKSpriteNode *kafei_man;
@property (nonatomic, weak) SKSpriteNode *tv_man;
@property (nonatomic, weak) SKSpriteNode *music_man;
@property (nonatomic, weak) SKSpriteNode *bfast_man;


-(void)show_chinese_translation:(NSString*)chinese_character pinyin:(NSString*)pinyin english:(NSString*)english touch_loc:(CGPoint)touchLocationInView;
@end
