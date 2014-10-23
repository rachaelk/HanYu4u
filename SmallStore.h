//
//  SmallStore.h
//  HanYu4u
//
//  Created by Rachael Keller on 7/26/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

//FILE: SMALLSTORE
//PURPOSE:
//    To have show the items in aisles, like a supermarket, for the user.

#import <SpriteKit/SpriteKit.h>
#import "PMCustomKeyboard.h"
#include "buyable_goods.h"

@interface SmallStore : SKScene <UITextFieldDelegate>{
    #ifdef __cplusplus
    character_and_pinyin item_listing;
    #endif
}

@property UITextField *input_hanyu0;
@property (nonatomic, weak) NSString *user_input0;
@property (nonatomic) int aisle;
@property (nonatomic, weak) SKLabelNode *go_back;
@property (nonatomic, weak) SKLabelNode *switch_aisle;
@property (nonatomic, weak) SKSpriteNode *border_frame;
@property (nonatomic, weak) SKNode *aisle_master;
@property (nonatomic, strong) PMCustomKeyboard *customKeyboard;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, weak) SKSpriteNode *store_chat_window;
@property (nonatomic, weak) SKSpriteNode *store_chat_longer_sentence;
@property (nonatomic) CGFloat border_width;
@property (nonatomic) CGFloat border_height;
@property (nonatomic, weak) SKLabelNode *score0;

-(int)parse_amounts:(NSString *) amount;
-(void)handle_shopping:(NSString *) purchase_request;
-(void)show_chinese_translation:(NSString*)chinese_characters pinyin:(NSString*)pinyin price:(float)price touch_loc:(CGPoint)touchLocationInView;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(BOOL)textFieldDidEndEditing:(UITextField *)textField;
-(BOOL)textFieldShouldClear:(UITextField *)textField;

@end
