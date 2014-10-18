//
//  Dialog12.h
//  HanYu4u
//
//  Created by Rachael Keller on 8/11/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PMCustomKeyboard.h"

@interface Dialog3 : SKScene <UITextFieldDelegate>
@property UITextField *input_hanyu0;
@property (nonatomic, weak) NSString *user_input0;
@property (nonatomic) int flashed_number;
@property (nonatomic, weak) SKLabelNode *go_back;
@property (nonatomic, strong) SKLabelNode *flashed_number_label;
@property (nonatomic, weak) SKLabelNode *response;
@property (nonatomic, weak) NSString *flashed_number_content;
@property (nonatomic, weak) SKSpriteNode *border_frame;
@property (nonatomic, weak) SKNode *aisle_master;
@property (nonatomic, strong) PMCustomKeyboard *customKeyboard;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic) int emph;
@property (nonatomic, strong) SKLabelNode *emphasize100;
@property (nonatomic, strong) SKLabelNode *emphasize1000;
@property (nonatomic, strong) SKLabelNode *emphasize10000;
@property (nonatomic, weak) SKLabelNode *score0;

-(int)parse_amounts:(NSString *) amount;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(BOOL)textFieldDidEndEditing:(UITextField *)textField;
-(BOOL)textFieldShouldClear:(UITextField *)textField;


@end
