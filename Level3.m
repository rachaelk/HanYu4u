//
//  Level10.m
//  HanYu4u
//
//  Created by Rachael Keller on 8/9/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "Level3.h"
#import "Dialog3.h"
#import "Base_Scene.h"
#import <UIKit/UIKit.h>

@implementation Level3

@synthesize lblScore = _lblScore;
@synthesize dialog_start10 = _dialog_start10;
@synthesize go_back = _go_back;
@synthesize change_page = _change_page;

@synthesize sentence1a = _sentence1a;
@synthesize sentence1b = _sentence1b;
@synthesize sentence1c = _sentence1c;
@synthesize sentence1d = _sentence1d;
@synthesize sentence2a = _sentence2a;
@synthesize sentence2b = _sentence2b;
@synthesize sentence2c = _sentence2c;
@synthesize sentence2d = _sentence2d;
@synthesize sentence3a = _sentence3a;
@synthesize sentence3b = _sentence3b;
@synthesize sentence3c = _sentence3c;
@synthesize sentence3d = _sentence3d;
@synthesize sentence4a = _sentence4a;
@synthesize sentence4b = _sentence4b;
@synthesize sentence4c = _sentence4c;
@synthesize sentence4d = _sentence4d;
@synthesize sentence5a = _sentence5a;
@synthesize sentence5b = _sentence5b;
@synthesize sentence5c = _sentence5c;

@synthesize sentence6a = _sentence6a;
@synthesize sentence6b = _sentence6b;
@synthesize sentence6c = _sentence6c;

@synthesize sentence7a = _sentence7a;
@synthesize sentence7b = _sentence7b;
@synthesize sentence7c = _sentence7c;

@synthesize sentence8a = _sentence8a;
@synthesize sentence8b = _sentence8b;
@synthesize sentence8c = _sentence8c;



-(void)show_chinese_translation:(NSString*)chinese_character pinyin:(NSString*)pinyin english:(NSString*)english touch_loc:(CGPoint)touchLocationInView{
    
    for (UIView *subview in [self.view subviews]) {
        // Only remove the subviews with tag not equal to 1
        if (subview.tag == 9) {
            [subview removeFromSuperview];
        }
    }
    
    UILabel *explanationField = [[UILabel alloc] initWithFrame:self.frame];
    explanationField.tag = 9;
    [explanationField setFont:[UIFont fontWithName:@"EuphemiaUCAS-Bold" size:8.0f]];
    explanationField.textColor=[UIColor whiteColor];
    explanationField.backgroundColor=[UIColor blackColor];
    explanationField.alpha = 0.8;
    explanationField.numberOfLines = 3;
    //string of explanation~~~~~~~~~~~
    
    NSString *explanation=[NSString stringWithFormat:@"%@\n%@\n%@\n",chinese_character,pinyin,english];
    //~~~~~~~~~~~~~~~~~~~end explanation
    explanationField.text = explanation;
    CGPoint mid = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    explanationField.adjustsFontSizeToFitWidth = true;
    explanationField.lineBreakMode = false;
    explanationField.textAlignment = NSTextAlignmentCenter;
    CGPoint positionInScene = touchLocationInView;
    
    CGFloat xPosition = positionInScene.x - 0.15*(positionInScene.x);
    CGFloat yPosition = positionInScene.y + 0.04*(positionInScene.y + mid.y) ;
    
    CGRect labelFrame = explanationField.frame;
    [explanationField adjustsFontSizeToFitWidth ];
    explanationField.frame = labelFrame;
    [explanationField sizeToFit];
    
    CGRect frame = explanationField.frame;
    frame.origin.y= yPosition;//pass the cordinate which you want
    frame.origin.x= xPosition;//pass the cordinate which you want
    explanationField.frame= frame;
    
    
    explanationField.layer.borderColor = [UIColor redColor].CGColor;
    explanationField.layer.borderWidth = 1.0;
    
    [self.view addSubview:explanationField];
    
    
    
    
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        
        
        // Score
        //~~~~~~~~~~~~~~~~~~~~~
        _lblScore = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _lblScore.fontSize = 12;
        _lblScore.fontColor = [SKColor redColor];
        _lblScore.position = CGPointMake(self.frame.origin.x + 0.7*self.frame.size.width,self.frame.origin.y + 0.80*self.frame.size.height);
        [_lblScore setText:@"0"];
        [_lblScore setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
        [self addChild:_lblScore];
        
        //to be put next to score
        SKLabelNode *currency = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        currency.fontSize = 12;
        currency.fontColor = [SKColor redColor];
        [currency setText:@"RMB (快/元)"];
        currency.position = CGPointMake(0.5*(_lblScore.position.x + _lblScore.frame.size.width + self.frame.size.width),_lblScore.position.y);
        [self addChild:currency];
        
        
        
        //dialog controller~~~~~~~~~~~~
        double padding = 0.2;
        
        
        _dialog_start10 = [SKLabelNode  labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _dialog_start10.name = @"dialog_start10";
        _dialog_start10.fontSize = 8;
        _dialog_start10.text = @"给我小考试吧！Quiz~";
        
        _dialog_start10.fontSize = 12;
        _dialog_start10.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _dialog_start10.position = CGPointMake(CGRectGetMinX(self.frame)+80, CGRectGetMinY(self.frame)+50);
        _dialog_start10.zPosition = 1; //sets it on foreground
        
        SKSpriteNode *button_dialog = [SKSpriteNode spriteNodeWithImageNamed:@"blue_button"];
        button_dialog.xScale = 0.7;
        button_dialog.yScale = 0.6;
        button_dialog.position = CGPointMake(_dialog_start10.position.x,_dialog_start10.position.y+ padding *_dialog_start10.frame.size.height);
        
        [self addChild: _dialog_start10];
        [self addChild:button_dialog];
        //~~~~~~~~~~~~~~~~dialog controller
        
        
        _change_page = [SKLabelNode  labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _change_page.name = @"change_page";
        _change_page.fontSize = 8;
        _change_page.text = @"下页"; //initial is next, at call to touch, change text to shangye
        
        _change_page.fontSize = 12;
        _change_page.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _change_page.position = CGPointMake(CGRectGetMaxX(self.frame)-80, CGRectGetMinY(self.frame)+50);
        _change_page.zPosition = 1; //sets it on foreground
        
        SKSpriteNode *button_page = [SKSpriteNode spriteNodeWithImageNamed:@"return"];
        button_page.xScale = 0.7;
        button_page.yScale = 0.6;
        button_page.position = CGPointMake(_change_page.position.x, _change_page.position.y + padding*_change_page.frame.size.height);
        
        [self addChild: _change_page];
        [self addChild:button_page];
        
        //previous_scene controller~~~~~~~~~~~~
        _go_back = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _go_back.name = @"go_back";
        _go_back.fontSize = 12;
        _go_back.text = @"Go Back";
        _go_back.zPosition = 1; //set on foreground
        _go_back.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _go_back.position = CGPointMake(_dialog_start10.position.x, 0.5*(CGRectGetMinY(self.frame) + _dialog_start10.position.y ));
        SKSpriteNode *button_scene = [SKSpriteNode spriteNodeWithImageNamed:@"blue_button"];
        button_scene.xScale = 0.35;
        button_scene.yScale = 0.6;
        button_scene.position = CGPointMake(_go_back.position.x,_go_back.position.y+ padding * _go_back.frame.size.height);
        
        [self addChild: _go_back];
        [self addChild:button_scene];
        //~~~~~~~~~~~~~~~~previous_page controller
        
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Chinese Words~~~~~~~~~~~~~~~~~~~~~~~
        int max_buffer_c0 = 0;
        int max_buffer_c1 = 0;
        int max_buffer_c2 = 0;
        int max_buffer_c3 = 0;
        
        float buffer = 1.85;
        
        SKLabelNode *sentence0a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        sentence0a.name = @"yi gong";
        sentence0a.text = @" ";
        sentence0a.fontSize = 14;
        sentence0a.fontColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1];
        sentence0a.position = CGPointMake(CGRectGetMinX(self.frame)+30, _lblScore.position.y);
        
        SKLabelNode *sentence0b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        sentence0b.name = @"you";
        sentence0b.text = @"号码";
        sentence0b.fontSize = 14;
        sentence0b.fontColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1];
        sentence0b.position = CGPointMake(sentence0a.position.x+30, sentence0a.position.y);
        
        SKLabelNode *sentence0c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        sentence0c.name = @"duoshao";
        sentence0c.text = @" ";
        sentence0c.fontSize = 14;
        sentence0c.fontColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1];
        sentence0c.position = CGPointMake(sentence0b.position.x+30, sentence0a.position.y);
        
        
        
        _sentence1a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1a.name = @"numbers";
        _sentence1a.text = @"一 二 三 四 五 六 七 八 九 十";
        if(_sentence1a.text.length > max_buffer_c0){max_buffer_c0 = _sentence1a.text.length;}
        _sentence1a.fontSize = 14;
        _sentence1a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        
        
        
        _sentence2a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2a.name = @"one";
        _sentence2a.text = @"一 1";
        if(_sentence2a.text.length > max_buffer_c0){max_buffer_c0 = _sentence2a.text.length;}
        _sentence2a.fontSize = 14;
        _sentence2a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        _sentence2b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2b.name = @"yi";
        _sentence2b.text = @"1";
        if(_sentence2b.text.length > max_buffer_c1){max_buffer_c1 = _sentence2b.text.length;}
        _sentence2b.fontSize = 14;
        _sentence2b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence2c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2c.name = @"si";
        _sentence2c.text = @"四";
        if(_sentence2c.text.length > max_buffer_c2){max_buffer_c2 = _sentence2c.text.length;}
        _sentence2c.fontSize = 14;
        _sentence2c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence2d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2d.name = @"cha";
        _sentence2d.text = @"4";
        if(_sentence2d.text.length > max_buffer_c3){max_buffer_c3 = _sentence2d.text.length;}
        _sentence2d.fontSize = 14;
        _sentence2d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        
        
        _sentence3a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3a.name = @"qi";
        _sentence3a.text = @"七";
        if(_sentence3a.text.length > max_buffer_c0){max_buffer_c0 = _sentence3a.text.length;}
        _sentence3a.fontSize = 14;
        _sentence3a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence3b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3b.name = @"qin";
        _sentence3b.text = @"7";
        if(_sentence3b.text.length > max_buffer_c1){max_buffer_c1 = _sentence3b.text.length;}
        _sentence3b.fontSize = 14;
        _sentence3b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence3c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3c.name = @"jiu";
        _sentence3c.text = @"九";
        if(_sentence3c.text.length > max_buffer_c2){max_buffer_c2 = _sentence3c.text.length;}
        _sentence3c.fontSize = 14;
        _sentence3c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence3d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3d.name = @"9";
        _sentence3d.text = @"9";
        _sentence3d.fontSize = 14;
        if(_sentence3d.text.length > max_buffer_c3){max_buffer_c3 = _sentence3d.text.length;}
        _sentence3d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        
        
        
        
        _sentence4a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4a.name = @"ling";
        _sentence4a.text = @"零";
        if(_sentence4a.text.length > max_buffer_c0){max_buffer_c0 = _sentence4a.text.length;}
        _sentence4a.fontSize = 14;
        _sentence4a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        _sentence4b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4b.name = @"0";
        _sentence4b.text = @"0";
        if(_sentence4b.text.length > max_buffer_c1){max_buffer_c1 = _sentence4b.text.length;}
        _sentence4b.fontSize = 14;
        _sentence4b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence4c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4c.name = @"shi";
        _sentence4c.text = @"十";
        if(_sentence4c.text.length > max_buffer_c2){max_buffer_c2 = _sentence4c.text.length;}
        _sentence4c.fontSize = 14;
        _sentence4c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence4d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4d.name = @"10";
        _sentence4d.text = @"10";
        _sentence4d.fontSize = 14;
        if(_sentence4d.text.length > max_buffer_c3){max_buffer_c3 = _sentence4d.text.length;}
        _sentence4d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        
        //NEXT PAGE~~
        _sentence5a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5a.name = @"fiftysix";
        _sentence5a.text = @"五十六 56";
        _sentence5a.fontSize = 14;
        if(_sentence5a.text.length > max_buffer_c0){max_buffer_c0 = _sentence5a.text.length;}
        _sentence5a.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence5b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5b.name = @"56";
        _sentence5b.text = @" ";
        if(_sentence5b.text.length > max_buffer_c1){max_buffer_c1 = _sentence5b.text.length;}
        _sentence5b.fontSize = 14;
        _sentence5b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence5c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5c.name = @"yibaoliu";
        _sentence5c.text = @"一百六 160";
        if(_sentence5c.text.length > max_buffer_c2){max_buffer_c2 = _sentence5c.text.length;}
        _sentence5c.fontSize = 14;
        _sentence5c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        
        
        _sentence6a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6a.name = @"yibailingqi ";
        _sentence6a.text = @"一百零七 107";
        _sentence6a.fontSize = 14;
        if(_sentence6a.text.length > max_buffer_c0){max_buffer_c0 = _sentence6a.text.length;}
        _sentence6a.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence6b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6b.name = @"a";
        _sentence6b.text = @" ";
        if(_sentence6b.text.length > max_buffer_c1){max_buffer_c1 = _sentence6b.text.length;}
        _sentence6b.fontSize = 14;
        _sentence6b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence6c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6c.name = @"yi qian wu";
        _sentence6c.text = @"一千三百五十三 1353";
        if(_sentence6c.text.length > max_buffer_c2){max_buffer_c2 = _sentence6c.text.length;}
        _sentence6c.fontSize = 14;
        _sentence6c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence7a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7a.name = @"shier";
        _sentence7a.text = @"十二 12";
        _sentence7a.fontSize = 14;
        if(_sentence7a.text.length > max_buffer_c0){max_buffer_c0 = _sentence7a.text.length;}
        _sentence7a.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence7b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7b.name = @"1353";
        _sentence7b.text = @" ";
        if(_sentence7b.text.length > max_buffer_c1){max_buffer_c1 = _sentence7b.text.length;}
        _sentence7b.fontSize = 14;
        _sentence7b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence7c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7c.name = @"yiqianwu";
        _sentence7c.text = @"一千零五十二 1052";
        if(_sentence7c.text.length > max_buffer_c2){max_buffer_c2 = _sentence7c.text.length;}
        _sentence7c.fontSize = 14;
        _sentence7c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence8a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8a.name = @"ba";
        _sentence8a.text = @"八百零五 805";
        _sentence8a.fontSize = 14;
        if(_sentence8a.text.length > max_buffer_c0){max_buffer_c0 = _sentence7a.text.length;}
        _sentence8a.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence8b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8b.name = @"zhi";
        _sentence8b.text = @" ";
        if(_sentence8b.text.length > max_buffer_c1){max_buffer_c1 = _sentence7b.text.length;}
        _sentence8b.fontSize = 14;
        _sentence8b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence8c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8c.name = @"bab";
        _sentence8c.text = @"一百五十 150";
        if(_sentence8c.text.length > max_buffer_c2){max_buffer_c2 = _sentence7c.text.length;}
        _sentence8c.fontSize = 14;
        _sentence8c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Chinese Words end
        
        NSMutableString *string_pad0 = [[NSMutableString alloc]init];
        NSMutableString *string_pad1 = [[NSMutableString alloc]init];
        NSMutableString *string_pad2 = [[NSMutableString alloc]init];
        NSString *space = @"啊";
        for (int i = 0; i <= max_buffer_c0; ++i){ [string_pad0 appendString:space];}
        for (int i = 0; i <= max_buffer_c1; ++i){ [string_pad1 appendString:space];}
        for (int i = 0; i <= max_buffer_c3; ++i){ [string_pad2 appendString:space];}
        
        SKLabelNode *pad0 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        pad0.name = @"pad0";
        pad0.text = string_pad0;
        pad0.fontSize = 14;
        SKLabelNode *pad1 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        pad1.name = @"pad1";
        pad1.text = string_pad1;
        pad1.fontSize = 14;
        SKLabelNode *pad2 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        pad2.name = @"pad2";
        pad2.text = string_pad2;
        pad2.fontSize = 14;
        
        //FIRST PAGE~~~ >>shangye<< 上页
        
        
        
        _sentence2a.position = CGPointMake(CGRectGetMinX((self.frame))+50,  CGRectGetMidY(self.frame));
        _sentence2b.position =  CGPointMake((_sentence2a.position.x) + 3*abs(buffer* _sentence2a.frame.size.width ), _sentence2a.position.y);
        _sentence2c.position = CGPointMake((_sentence2b.position.x)+  abs(buffer* _sentence2b.frame.size.width - pad1.frame.size.width), _sentence2a.position.y);
        _sentence2d.position = CGPointMake((_sentence2c.position.x)+   abs(buffer* _sentence2c.frame.size.width - pad2.frame.size.width), _sentence2a.position.y);
        
        _sentence1a.position = CGPointMake(CGRectGetMidX((self.frame)), 0.5*(_lblScore.position.y + _sentence2a.position.y));
        
        _sentence3a.position = CGPointMake(_sentence2a.position.x, _sentence2a.position.y- 30);
        _sentence3b.position = CGPointMake(_sentence1b.position.x, _sentence3a.position.y);
        _sentence3c.position = CGPointMake(_sentence1c.position.x, _sentence3a.position.y);
        _sentence3d.position = CGPointMake(_sentence1d.position.x,_sentence3a.position.y);
        
        
        _sentence4a.position = CGPointMake(_sentence3a.position.x, _sentence3a.position.y- 30);
        _sentence4b.position = CGPointMake(_sentence1b.position.x, _sentence4a.position.y);
        _sentence4c.position = CGPointMake(_sentence1c.position.x, _sentence4a.position.y);
        _sentence4d.position = CGPointMake(_sentence1d.position.x,_sentence4a.position.y);
        //NEXT PAGE~~~
        
        _sentence5a.position = CGPointMake(_sentence2a.position.x, _sentence2a.position.y);
        _sentence5b.position = CGPointMake(_sentence2b.position.x,_sentence5a.position.y);
        _sentence5c.position = CGPointMake(_sentence2d.position.x, _sentence5a.position.y);
        
        _sentence6a.position = CGPointMake(_sentence2a.position.x, _sentence5a.position.y - 30);
        _sentence6b.position = CGPointMake(_sentence2b.position.x,_sentence6a.position.y);
        _sentence6c.position = CGPointMake(_sentence2d.position.x, _sentence6a.position.y);
        
        
        _sentence7a.position = CGPointMake(_sentence3a.position.x, _sentence6a.position.y - 30);
        _sentence7b.position = CGPointMake(_sentence2b.position.x,_sentence7a.position.y);
        _sentence7c.position = CGPointMake(_sentence2d.position.x, _sentence7a.position.y);
        
        _sentence8a.position = CGPointMake(_sentence4a.position.x, _sentence7a.position.y - 30);
        _sentence8b.position = CGPointMake(_sentence2b.position.x,_sentence8a.position.y);
        _sentence8c.position = CGPointMake(_sentence2d.position.x, _sentence8a.position.y);
        
        
        //add nodes begin~~~~
        [self addChild:sentence0a];
        [self addChild:sentence0b];
        [self addChild:sentence0c];
        [self addChild:_sentence1a];
        
        [self addChild:_sentence2a];
        [self addChild:_sentence2b];
        [self addChild:_sentence2c];
        [self addChild:_sentence2d];
        [self addChild:_sentence3a];
        [self addChild:_sentence3b];
        [self addChild:_sentence3c];
        [self addChild:_sentence3d];
        [self addChild:_sentence4a];
        [self addChild:_sentence4b];
        [self addChild:_sentence4c];
        [self addChild:_sentence4d];
        [self addChild:_sentence5a];
        [self addChild:_sentence5b];
        [self addChild:_sentence5c];
        [self addChild:_sentence6a];
        [self addChild:_sentence6b];
        [self addChild:_sentence6c];
        
        [self addChild:_sentence7a];
        [self addChild:_sentence7b];
        [self addChild:_sentence7c];
        
        [self addChild:_sentence8a];
        [self addChild:_sentence8b];
        [self addChild:_sentence8c];
        
        //~~~~~~~~~~~end add nodes
        
    }
    _sentence1a.hidden = false;
    _sentence1b.hidden = true;
    
    _sentence2a.hidden = true;
    _sentence2b.hidden = true;
    _sentence2c.hidden = true;
    _sentence2d.hidden = true;
    _sentence3a.hidden = true;
    _sentence3b.hidden = true;
    _sentence3c.hidden = true;
    _sentence3d.hidden = true;
    _sentence4a.hidden = true;
    _sentence4b.hidden = true;
    _sentence4c.hidden = true;
    _sentence4d.hidden = true;
    
    _sentence5a.hidden = false;
    _sentence5b.hidden = false;
    _sentence5c.hidden = false;
    
    _sentence6a.hidden = false;
    _sentence6b.hidden = false;
    _sentence6c.hidden = false;
    _sentence7a.hidden = false;
    _sentence7b.hidden = false;
    _sentence7c.hidden = false;
    _sentence8a.hidden = false;
    _sentence8b.hidden = false;
    _sentence8c.hidden = false;
    
    
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        CGPoint touchLocationInView = [touch locationInView:self.scene.view];
        
        for (SKNode *node in nodes) {
            
            
            if( [node.name isEqualToString:@"dialog_start10"]){
                
                for (UIView *subview in [self.view subviews]) {
                    // Only remove the subviews with tag not equal to 7 <<not for new load
                    if (subview.tag == 9 || subview.tag == 7) {
                        [subview removeFromSuperview];
                    }
                }
                
                SKView *spriteView = (SKView *) self.view;
                SKScene *currentScene = [spriteView scene];
                Dialog3 *newScene = [Dialog3 sceneWithSize:spriteView.bounds.size];
                
                if(!currentScene.userData){
                    [spriteView presentScene:newScene];
                }
                
                else{
                    newScene.userData = [NSMutableDictionary dictionary];
                    [newScene.userData setObject:[currentScene.userData objectForKey:@"image_index"] forKey:@"image_index"];
                    [spriteView presentScene:newScene];
                }
                
                
            }
            
            
            if( [node.name isEqualToString:@"go_back"]){
                
                for (UIView *subview in [self.view subviews]) {
                    
                    //if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    // }
                }
                
                
                SKView *spriteView = (SKView *) self.view;
                Base_Scene *newScene = [Base_Scene sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
                
            }
            
            if( [node.name isEqualToString:@"change_page"]){
                
                for (UIView *subview in [self.view subviews]) {
                    // Only remove the subviews with tag not equal to 1
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
               
            }
            
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //Word Explanations BEGIN~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            
            
            if (([node.name isEqualToString:@"you"])&& (node.hidden == false)){
                
                [self show_chinese_translation:@"号码" pinyin:@"hàomǎ" english:@"numbers" touch_loc:touchLocationInView ];
                
            }
            
            
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //Word Explanations END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            else{
                for (UIView *subview in [self.view subviews]) {
                if (subview.tag == 9 || subview.tag == 7) {
                    [subview removeFromSuperview];
                }}
            }
            
        }
    }
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
