//
//  MarketPlace.h
//  HanYu4u
//
//  Created by Rachael Keller on 7/31/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PMCustomKeyboard.h"
#include "buyable_goods.h"

@interface MarketPlace : SKScene <UITextFieldDelegate>{
    #ifdef __cplusplus
    character_and_pinyin item_listing;
    #endif
}


@property UITextField *input_hanyu0;
@property (nonatomic, weak) NSString *user_input0;
@property (nonatomic, weak) SKLabelNode *go_back;
@property (nonatomic, weak) SKLabelNode *request_cheaper;
@property (nonatomic, weak) SKLabelNode *request_poor_student;
@property (nonatomic, weak) SKLabelNode *request_meiyou_qian;
@property (nonatomic, weak) SKLabelNode *request_material;
@property (nonatomic, weak) SKLabelNode *request_wait;
@property (nonatomic, weak) SKNode *dialogue_master;

@property (nonatomic, weak) SKLabelNode *lblScore;

@property (nonatomic, weak) SKSpriteNode *stick_figure;
@property (nonatomic, strong) PMCustomKeyboard *customKeyboard;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, weak) SKSpriteNode *store_chat_window;
@property (nonatomic, weak) SKSpriteNode *store_chat_longer_sentence;
@property (nonatomic) float probability_success_haggle;
@property (nonatomic) float price_userRequest;
@property (nonatomic) float price_sellerRequest;
@property (nonatomic, strong) NSMutableArray* trophy_prices;
@property (atomic)int trophy_considered;
@property (atomic, strong) NSString *choice_made;
@property (nonatomic) int iterations_cheaper;
@property (nonatomic) int iterations_poor_student;
@property (nonatomic) int iterations_wait;
@property (nonatomic) int iterations_no_money;

-(int)parse_amounts:(NSString *) amount;
-(void)handle_shopping:(NSString *) purchase_request;
-(void)show_dialogue:(NSString*)store_owner_question item_cost_text:(NSString*)item_cost_text price:(float)price touch_loc:(CGPoint)touchLocationInView;
-(void)unhide_dialogue_choices;
-(void)seller_responses:(NSString*)store_owner_response;
-(void)handle_haggle:(float)requested_price actual_price:(float)actual_price probability_change:(float)prob_change;

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(BOOL)textFieldDidEndEditing:(UITextField *)textField;
-(BOOL)textFieldShouldClear:(UITextField *)textField;


@end
