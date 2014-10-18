//
//  Dialog1.h
//  HanYu4u
//
//  Created by Rachael Keller on 8/7/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Base_Storyboard.h"
#import "PMCustomKeyboard.h"


@interface Dialog1 : SKScene <UITextFieldDelegate>

@property UITextField *input_hanyu;
@property (nonatomic, weak) NSString *user_input;
@property (nonatomic, weak) NSString *flashed_word;
@property (nonatomic, weak) SKSpriteNode *image_out;
@property (nonatomic, weak) SKNode *images;
@property (nonatomic, weak) SKLabelNode *score;
@property (nonatomic, weak) SKLabelNode *win;
@property (nonatomic, weak) SKLabelNode *incorrect;
@property (nonatomic, weak) SKLabelNode *go_back;
@property (nonatomic, strong) PMCustomKeyboard *customKeyboard;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(BOOL)textFieldDidEndEditing:(UITextField *)textField;
-(BOOL)textFieldShouldClear:(UITextField *)textField;
-(void)check_if_out;
-(void)dismissKeyboard;
-(void) check_word:(NSString*)input word:(NSString *) word;
-(SKSpriteNode*) shuffleHanyu:(int)ref len:(int)len array:(NSArray *)words;

@end
