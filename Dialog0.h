//
//  Dialog0.h
//  HanYu4u
//
//  Created by Rachael Keller on 7/21/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Base_Storyboard.h"
#import "PMCustomKeyboard.h"


@interface Dialog0 : SKScene <UITextFieldDelegate>

@property UITextField *input_hanyu0;
@property (nonatomic, weak) NSString *user_input0;
@property (nonatomic, weak) NSString *flashed_word0;
@property (nonatomic, weak) SKSpriteNode *image_out0;
@property (nonatomic, weak) SKNode *images;
@property (nonatomic, weak) SKLabelNode *score0;
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
