
// 
//   Level3.m
//   HanYu4u
// 
//   Created by Rachael Keller on 7/19/14.
//   Copyright (c) 2014 Rachael Keller. All rights reserved.
// 

#import "Level13.h"
#import "Dialog13.h"
#import "Base_Scene.h"
#import <UIKit/UIKit.h>

@implementation Level13

@synthesize lblScore = _lblScore;
@synthesize dialog_start13 = _dialog_start13;
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
@synthesize sentence5d = _sentence5d;
@synthesize sentence6a = _sentence6a;
@synthesize sentence6b = _sentence6b;
@synthesize sentence6c = _sentence6c;
@synthesize sentence6d = _sentence6d;
@synthesize sentence7a = _sentence7a;
@synthesize sentence7b = _sentence7b;
@synthesize sentence7c = _sentence7c;
@synthesize sentence7d = _sentence7d;


@synthesize sentence8a = _sentence8a;
@synthesize sentence8b = _sentence8b;
@synthesize sentence8c = _sentence8c;
@synthesize sentence8d = _sentence8d;


@synthesize sentence1 = _sentence1;
@synthesize sentence2 = _sentence2;
@synthesize sentence3 = _sentence3;
@synthesize sentence4 = _sentence4;
@synthesize sentence5 = _sentence5;
@synthesize sentence6 = _sentence6;
@synthesize sentence7 = _sentence7;
@synthesize sentence8 = _sentence8;


-(void)show_chinese_translation:(NSString*)chinese_character pinyin:(NSString*)pinyin english:(NSString*)english touch_loc:(CGPoint)touchLocationInView{
    
    for (UIView *subview in [self.view subviews]) {
        //  Only remove the subviews with tag not equal to 1
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
    // string of explanation~~~~~~~~~~~
    
    NSString *explanation=[NSString stringWithFormat:@"%@\n%@\n%@\n",chinese_character,pinyin,english];
    // ~~~~~~~~~~~~~~~~~~~end explanation
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
    frame.origin.y= yPosition;// pass the cordinate which you want
    frame.origin.x= xPosition;// pass the cordinate which you want
    explanationField.frame= frame;
    
    
    explanationField.layer.borderColor = [UIColor redColor].CGColor;
    explanationField.layer.borderWidth = 1.0;
    
    [self.view addSubview:explanationField];
    
    
    
    
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        //  Score
        // ~~~~~~~~~~~~~~~~~~~~~
        _lblScore = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _lblScore.fontSize = 12;
        _lblScore.fontColor = [SKColor redColor];
        _lblScore.position = CGPointMake(self.frame.origin.x + 0.7*self.frame.size.width,self.frame.origin.y + 0.80*self.frame.size.height);
        [_lblScore setText:@"0"];
        [_lblScore setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
        [self addChild:_lblScore];
        
        // to be put next to score
        SKLabelNode *currency = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        currency.fontSize = 12;
        currency.fontColor = [SKColor redColor];
        [currency setText:@"RMB (快/元)"];
        currency.position = CGPointMake(0.5*(_lblScore.position.x + _lblScore.frame.size.width + self.frame.size.width),_lblScore.position.y);
        [self addChild:currency];
        
        
        
        // dialog controller~~~~~~~~~~~~
        double padding = 0.2;
        
        
        _dialog_start13 = [SKLabelNode  labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _dialog_start13.name = @"dialog_start13";
        _dialog_start13.fontSize = 8;
        _dialog_start13.text = @"给我小考试吧！Quiz~";
        
        _dialog_start13.fontSize = 12;
        _dialog_start13.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _dialog_start13.position = CGPointMake(CGRectGetMinX(self.frame)+80, CGRectGetMinY(self.frame)+50);
        _dialog_start13.zPosition = 1; // sets it on foreground
        
        SKSpriteNode *button_dialog = [SKSpriteNode spriteNodeWithImageNamed:@"blue_button"];
        button_dialog.xScale = 0.7;
        button_dialog.yScale = 0.6;
        button_dialog.position = CGPointMake(_dialog_start13.position.x,_dialog_start13.position.y+ padding *_dialog_start13.frame.size.height);
        
        [self addChild: _dialog_start13];
        [self addChild:button_dialog];
        
        // ~~~~~~~~~~~~~~~~dialog controller
        // previous_page controller~~~~~~~~~~~~
        _go_back = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _go_back.name = @"go_back";
        _go_back.fontSize = 12;
        _go_back.text = @"Go Back";
        _go_back.zPosition = 1; // set on foreground
        _go_back.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _go_back.position = CGPointMake(_dialog_start13.position.x, 0.5*(CGRectGetMinY(self.frame) + _dialog_start13.position.y ));
        SKSpriteNode *button_scene = [SKSpriteNode spriteNodeWithImageNamed:@"blue_button"];
        button_scene.xScale = 0.35;
        button_scene.yScale = 0.6;
        button_scene.position = CGPointMake(_go_back.position.x,_go_back.position.y+ padding * _go_back.frame.size.height);
        
        [self addChild: _go_back];
        [self addChild:button_scene];
        // ~~~~~~~~~~~~~~~~previous_page controller
        
        
        _change_page = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _change_page.name = @"change_page";
        _change_page.fontSize = 8;
        _change_page.text = @"下页"; // initial is next, at call to touch, change text to shangye
        _change_page.fontSize = 12;
        _change_page.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _change_page.position = CGPointMake(CGRectGetMaxX(self.frame)-80, CGRectGetMinY(self.frame)+50);
        _change_page.zPosition = 1; // sets it on foreground
        
        SKSpriteNode *button_page = [SKSpriteNode spriteNodeWithImageNamed:@"return"];
        button_page.xScale = 0.7;
        button_page.yScale = 0.6;
        button_page.position = CGPointMake(_change_page.position.x, _change_page.position.y + padding*_change_page.frame.size.height);
        
        [self addChild: _change_page];
        [self addChild:button_page];
        
        
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        // Chinese Words~~~~~~~~~~~~~~~~~~~~~~~
        int max_buffer_c0 = 0;
        int max_buffer_c1 = 0;
        int max_buffer_c2 = 0;
        int max_buffer_c3 = 0;
        
        float buffer = 1.85;
        
        SKLabelNode *sentence0a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        sentence0a.name = @"shenmeshihou";
        sentence0a.text = @"什么时候";
        sentence0a.fontSize = 14;
        sentence0a.fontColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1];
        sentence0a.position = CGPointMake(CGRectGetMinX(self.frame)+30, _lblScore.position.y);
        
        
        
        _sentence1a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1a.name = @"ta_m";
        _sentence1a.text = @"他";
        if(_sentence1a.text.length > max_buffer_c0){max_buffer_c0 = _sentence1a.text.length;}
        _sentence1a.fontSize = 14;
        _sentence1a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        _sentence1b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1b.name = @"shangwu1";
        _sentence1b.text = @"上午";
        if(_sentence1b.text.length > max_buffer_c1){max_buffer_c1 = _sentence1b.text.length;}
        _sentence1b.fontSize = 14;
        _sentence1b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence1c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1c.name = @"qidianzhong";
        _sentence1c.text = @"七点钟";
        if(_sentence1c.text.length > max_buffer_c2){max_buffer_c2 = _sentence1c.text.length;}
        _sentence1c.fontSize = 14;
        _sentence1c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence1d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1d.name = @"kanshu";
        _sentence1d.text = @"看书。";
        if(_sentence1d.text.length > max_buffer_c3){max_buffer_c3 = _sentence1d.text.length;}
        _sentence1d.fontSize = 14;
        _sentence1d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        
        
        SKSpriteNode *bfast_man = [SKSpriteNode spriteNodeWithImageNamed:@"kanshu7am"];
        [bfast_man setScale:0.25];
        
        
        
        _sentence2a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2a.name = @"ta_m2";
        _sentence2a.text = @"他";
        if(_sentence2a.text.length > max_buffer_c0){max_buffer_c0 = _sentence2a.text.length;}
        _sentence2a.fontSize = 14;
        _sentence2a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        _sentence2b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2b.name = @"shangwu2";
        _sentence2b.text = @"上午";
        if(_sentence2b.text.length > max_buffer_c1){max_buffer_c1 = _sentence2b.text.length;}
        _sentence2b.fontSize = 14;
        _sentence2b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence2c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2c.name = @"jiudianzhong";
        _sentence2c.text = @"九点钟";
        if(_sentence2c.text.length > max_buffer_c2){max_buffer_c2 = _sentence2c.text.length;}
        _sentence2c.fontSize = 14;
        _sentence2c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence2d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2d.name = @"kandianshi";
        _sentence2d.text = @"看电视。";
        if(_sentence2d.text.length > max_buffer_c3){max_buffer_c3 = _sentence2d.text.length;}
        _sentence2d.fontSize = 14;
        _sentence2d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        
        SKSpriteNode *kafei_man = [SKSpriteNode spriteNodeWithImageNamed:@"hekafei"];
        [kafei_man setScale:0.28];
        
        
        _sentence3a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3a.name = @"ta_f1";
        _sentence3a.text = @"她";
        if(_sentence3a.text.length > max_buffer_c0){max_buffer_c0 = _sentence3a.text.length;}
        _sentence3a.fontSize = 14;
        _sentence3a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence3b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3b.name = @"xiawu";
        _sentence3b.text = @"下午";
        if(_sentence3b.text.length > max_buffer_c1){max_buffer_c1 = _sentence3b.text.length;}
        _sentence3b.fontSize = 14;
        _sentence3b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence3c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3c.name = @"sandianzhong";
        _sentence3c.text = @"三点钟";
        if(_sentence3c.text.length > max_buffer_c2){max_buffer_c2 = _sentence3c.text.length;}
        _sentence3c.fontSize = 14;
        _sentence3c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence3d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3d.name = @"tingyinyue";
        _sentence3d.text = @"听音乐。";
        _sentence3d.fontSize = 14;
        if(_sentence3d.text.length > max_buffer_c3){max_buffer_c3 = _sentence3d.text.length;}
        _sentence3d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        SKSpriteNode *music_man = [SKSpriteNode spriteNodeWithImageNamed:@"music"];
        [music_man setScale:0.2];
        
        
        
        _sentence4a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4a.name = @"ta_f2";
        _sentence4a.text = @"她";
        if(_sentence4a.text.length > max_buffer_c0){max_buffer_c0 = _sentence4a.text.length;}
        _sentence4a.fontSize = 14;
        _sentence4a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        _sentence4b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4b.name = @"wanshang";
        _sentence4b.text = @"晚上";
        if(_sentence4b.text.length > max_buffer_c1){max_buffer_c1 = _sentence4b.text.length;}
        _sentence4b.fontSize = 14;
        _sentence4b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence4c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4c.name = @"badian";
        _sentence4c.text = @"八点";
        if(_sentence4c.text.length > max_buffer_c2){max_buffer_c2 = _sentence4c.text.length;}
        _sentence4c.fontSize = 14;
        _sentence4c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence4d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4d.name = @"tingyinyue1";
        _sentence4d.text = @"听音乐。";
        _sentence4d.fontSize = 14;
        if(_sentence4d.text.length > max_buffer_c3){max_buffer_c3 = _sentence4d.text.length;}
        _sentence4d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        
        SKSpriteNode *tv_man = [SKSpriteNode spriteNodeWithImageNamed:@"tv"];
        [tv_man setScale:0.2];
        
        
        _sentence5a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5a.name = @"ta_f3";
        _sentence5a.text = @"她";
        _sentence5a.fontSize = 14;
        if(_sentence5a.text.length > max_buffer_c0){max_buffer_c0 = _sentence5a.text.length;}
        _sentence5a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence5b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5b.name = @"shangwu3";
        _sentence5b.text = @"上午";
        if(_sentence5b.text.length > max_buffer_c1){max_buffer_c1 = _sentence5b.text.length;}
        _sentence5b.fontSize = 14;
        _sentence5b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence5c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5c.name = @"qidian";
        _sentence5c.text = @"七点";
        if(_sentence5c.text.length > max_buffer_c2){max_buffer_c2 = _sentence5c.text.length;}
        _sentence5c.fontSize = 14;
        _sentence5c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence5d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5d.name = @"paobu";
        _sentence5d.text = @"跑步。";
        if(_sentence5d.text.length > max_buffer_c3){max_buffer_c3 = _sentence5d.text.length;}
        _sentence5d.fontSize = 14;
        _sentence5d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        // NEXT PAGE~~
        
        _sentence6a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6a.name = @"ta_m3";
        _sentence6a.text = @"他";
        _sentence6a.fontSize = 14;
        if(_sentence6a.text.length > max_buffer_c0){max_buffer_c0 = _sentence6a.text.length;}
        _sentence6a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence6b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6b.name = @"wanshang1";
        _sentence6b.text = @"晚上";
        if(_sentence6b.text.length > max_buffer_c1){max_buffer_c1 = _sentence6b.text.length;}
        _sentence6b.fontSize = 14;
        _sentence6b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence6c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6c.name = @"wudianban";
        _sentence6c.text = @"五点半";
        if(_sentence6c.text.length > max_buffer_c2){max_buffer_c2 = _sentence6c.text.length;}
        _sentence6c.fontSize = 14;
        _sentence6c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence6d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6d.name = @"chiwanfan";
        _sentence6d.text = @"吃晚饭。";
        if(_sentence6d.text.length > max_buffer_c3){max_buffer_c3 = _sentence6d.text.length;}
        _sentence6d.fontSize = 14;
        _sentence6d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        _sentence7a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7a.name = @"ta_f4";
        _sentence7a.text = @"她";
        _sentence7a.fontSize = 14;
        if(_sentence7a.text.length > max_buffer_c0){max_buffer_c0 = _sentence7a.text.length;}
        _sentence7a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence7b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7b.name = @"xiawu1";
        _sentence7b.text = @"下午";
        if(_sentence7b.text.length > max_buffer_c1){max_buffer_c1 = _sentence7b.text.length;}
        _sentence7b.fontSize = 14;
        _sentence7b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence7c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7c.name = @"liangdian";
        _sentence7c.text = @"两点";
        if(_sentence7c.text.length > max_buffer_c2){max_buffer_c2 = _sentence7c.text.length;}
        _sentence7c.fontSize = 14;
        _sentence7c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence7d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7d.name = @"kandianshi";
        _sentence7d.text = @"看电视。";
        if(_sentence7d.text.length > max_buffer_c3){max_buffer_c3 = _sentence7d.text.length;}
        _sentence7d.fontSize = 14;
        _sentence7d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        _sentence8a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8a.name = @"ta_m4";
        _sentence8a.text = @"他";
        _sentence8a.fontSize = 14;
        if(_sentence8a.text.length > max_buffer_c0){max_buffer_c0 = _sentence7a.text.length;}
        _sentence8a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence8b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8b.name = @"xiawu2";
        _sentence8b.text = @"下午";
        if(_sentence8b.text.length > max_buffer_c1){max_buffer_c1 = _sentence7b.text.length;}
        _sentence8b.fontSize = 14;
        _sentence8b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence8c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8c.name = @"sandianban";
        _sentence8c.text = @"三点半";
        if(_sentence8c.text.length > max_buffer_c2){max_buffer_c2 = _sentence7c.text.length;}
        _sentence8c.fontSize = 14;
        _sentence8c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence8d = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8d.name = @"tizuqiu";
        _sentence8d.text = @"踢足球。";
        if(_sentence8d.text.length > max_buffer_c3){max_buffer_c3 = _sentence7d.text.length;}
        _sentence8d.fontSize = 14;
        _sentence8d.fontColor = [SKColor colorWithRed:0 green:0.4 blue:1 alpha:1];
        
        _sentence1 = [SKSpriteNode spriteNodeWithImageNamed:@"kanshu7am"];[_sentence1 setScale:0.3];
        _sentence2 = [SKSpriteNode spriteNodeWithImageNamed:@"tv9am"];[_sentence2 setScale:0.25];
        _sentence3 = [SKSpriteNode spriteNodeWithImageNamed:@"music3pm"];[_sentence3 setScale:0.25];
        _sentence4 = [SKSpriteNode spriteNodeWithImageNamed:@"music8pm"];[_sentence4 setScale:0.25];
        
        _sentence5 = [SKSpriteNode spriteNodeWithImageNamed:@"run7am"];
        [_sentence5 setScale:0.25];
        _sentence6 = [SKSpriteNode spriteNodeWithImageNamed:@"dinner5pm"];
        [_sentence6 setScale:0.25];
        _sentence7 = [SKSpriteNode spriteNodeWithImageNamed:@"tv2pm"];
        [_sentence7 setScale:0.25];
        _sentence8 = [SKSpriteNode spriteNodeWithImageNamed:@"soccer330pm"];
        [_sentence8 setScale:0.25];

        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Chinese Words end
        
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
        
        _sentence1a.position = CGPointMake(sentence0a.position.x + 20, sentence0a.position.y-70);
        _sentence1b.position = CGPointMake((_sentence1a.position.x) + 2*abs(buffer* _sentence1a.frame.size.width - pad1.frame.size.width), _sentence1a.position.y);
        _sentence1c.position = CGPointMake((_sentence1b.position.x)+0.5*(_sentence1b.frame.size.width+ abs(buffer* _sentence1a.frame.size.width - pad0.frame.size.width)) + abs(buffer* _sentence1b.frame.size.width - pad2.frame.size.width), _sentence1a.position.y);
        _sentence1d.position = CGPointMake((_sentence1c.position.x)+ 0.5*(_sentence1c.frame.size.width + _sentence1d.frame.size.width) + abs(buffer* _sentence1c.frame.size.width - pad2.frame.size.width), _sentence1a.position.y);
        
        _sentence2a.position = CGPointMake(_sentence1a.position.x,  _sentence1a.position.y-(_sentence1.size.height) - 10);
        _sentence2b.position = CGPointMake(_sentence1b.position.x, _sentence2a.position.y);
        _sentence2c.position = CGPointMake(_sentence1c.position.x,_sentence2a.position.y);
        _sentence2d.position = CGPointMake(_sentence1d.position.x,_sentence2a.position.y);
        
        _sentence3a.position = CGPointMake(_sentence2a.position.x, _sentence2a.position.y-(_sentence2.size.height) - 10);
        _sentence3b.position = CGPointMake(_sentence1b.position.x, _sentence3a.position.y);
        _sentence3c.position = CGPointMake(_sentence1c.position.x, _sentence3a.position.y);
        _sentence3d.position = CGPointMake(_sentence1d.position.x,_sentence3a.position.y);
        
        _sentence4a.position = CGPointMake(_sentence3a.position.x, _sentence3a.position.y-(_sentence3.size.height) - 10);
        _sentence4b.position = CGPointMake(_sentence1b.position.x, _sentence4a.position.y);
        _sentence4c.position = CGPointMake(_sentence1c.position.x, _sentence4a.position.y);
        _sentence4d.position = CGPointMake(_sentence1d.position.x,_sentence4a.position.y);
        
        
        // NEXT PAGE~~~
        _sentence5a.position = CGPointMake(_sentence1a.position.x, _sentence1b.position.y);
        _sentence5b.position = CGPointMake(_sentence1b.position.x,_sentence5a.position.y);
        _sentence5c.position = CGPointMake(_sentence1c.position.x, _sentence5a.position.y);
        _sentence5d.position = CGPointMake(_sentence1d.position.x,_sentence5a.position.y);
        
        _sentence6a.position = CGPointMake(_sentence5a.position.x, _sentence5a.position.y-(_sentence5.size.height) - 10);
        _sentence6b.position = CGPointMake(_sentence5b.position.x,_sentence6a.position.y);
        _sentence6c.position = CGPointMake(_sentence5c.position.x, _sentence6a.position.y);
        _sentence6d.position = CGPointMake(_sentence5d.position.x,_sentence6a.position.y);
        
        
        _sentence7a.position = CGPointMake(_sentence6a.position.x, _sentence6a.position.y -(_sentence6.size.height) - 10);
        _sentence7b.position = CGPointMake(_sentence6b.position.x,_sentence7a.position.y);
        _sentence7c.position = CGPointMake(_sentence6c.position.x, _sentence7a.position.y);
        _sentence7d.position = CGPointMake(_sentence6d.position.x,_sentence7a.position.y);
        
        _sentence8a.position = CGPointMake(_sentence7a.position.x, _sentence7a.position.y-(_sentence7.size.height) - 10);
        _sentence8b.position = CGPointMake(_sentence7b.position.x,_sentence8a.position.y);
        _sentence8c.position = CGPointMake(_sentence7c.position.x, _sentence8a.position.y);
        _sentence8d.position = CGPointMake(_sentence7d.position.x,_sentence8a.position.y);
        
        
        _sentence1.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence1d.position.x)/2, _sentence1d.position.y);
        _sentence2.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence2d.position.x)/2, _sentence2d.position.y);
        _sentence3.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence3d.position.x)/2, _sentence3d.position.y);
        _sentence4.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence4d.position.x)/2, _sentence4d.position.y);
        _sentence5.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence5d.position.x)/2, _sentence5d.position.y);
        _sentence6.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence6d.position.x)/2, _sentence6d.position.y);
        _sentence7.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence7d.position.x)/2, _sentence7d.position.y);
        _sentence8.position = CGPointMake((CGRectGetMaxX(self.frame)+ _sentence8d.position.x)/2, _sentence8d.position.y);
        
        
        // add nodes begin~~~~
        [self addChild:sentence0a];
        [self addChild:_sentence1a];
        [self addChild:_sentence1b];
        [self addChild:_sentence1c];
        [self addChild:_sentence1d];
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
        [self addChild:_sentence5d];
        [self addChild:_sentence6a];
        [self addChild:_sentence6b];
        [self addChild:_sentence6c];
        [self addChild:_sentence6d];
        [self addChild:_sentence7a];
        [self addChild:_sentence7b];
        [self addChild:_sentence7c];
        [self addChild:_sentence7d];
        [self addChild:_sentence8a];
        [self addChild:_sentence8b];
        [self addChild:_sentence8c];
        [self addChild:_sentence8d];
        // ~~~~~~~~~~~end add nodes
        
        [self addChild:_sentence1];
        [self addChild:_sentence2];
        [self addChild:_sentence3];
        [self addChild:_sentence4];
        [self addChild:_sentence5];
        [self addChild:_sentence6];
        [self addChild:_sentence7];
        [self addChild:_sentence8];
        
    }
    
    
    _sentence5a.hidden = true;
    _sentence5b.hidden = true;
    _sentence5c.hidden = true;
    _sentence5d.hidden = true;
    _sentence6a.hidden = true;
    _sentence6b.hidden = true;
    _sentence6c.hidden = true;
    _sentence6d.hidden = true;
    _sentence7a.hidden = true;
    _sentence7b.hidden = true;
    _sentence7c.hidden = true;
    _sentence7d.hidden = true;
    _sentence8a.hidden = true;
    _sentence8b.hidden = true;
    _sentence8c.hidden = true;
    _sentence8d.hidden = true;
    _sentence8d.hidden = true;
    _sentence5.hidden = true;
    _sentence6.hidden = true;
    _sentence7.hidden= true;
    _sentence8.hidden = true;
    
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        CGPoint touchLocationInView = [touch locationInView:self.scene.view];
        
        for (SKNode *node in nodes) {
            
            
            if( [node.name isEqualToString:@"dialog_start13"]){
                
                for (UIView *subview in [self.view subviews]) {
                    //  Only remove the subviews with tag not equal to 7 <<not for new load
                    if (subview.tag == 9 || subview.tag == 7) {
                        [subview removeFromSuperview];
                    }
                }
                
                SKView *spriteView = (SKView *) self.view;
                SKScene *currentScene = [spriteView scene];
                Dialog13 *newScene = [Dialog13 sceneWithSize:spriteView.bounds.size];
                
                if(!currentScene.userData){
                    [spriteView presentScene:newScene];
                }
                
                else{
                    newScene.userData = [NSMutableDictionary dictionary];
                    [newScene.userData setObject:[currentScene.userData objectForKey:@"image_index"] forKey:@"image_index"];
                    [spriteView presentScene:newScene];
                }
                
                
            }
            
            if( [node.name isEqualToString:@"change_page"]){
                
                for (UIView *subview in [self.view subviews]) {
                    //  Only remove the subviews with tag not equal to 1
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
                if([_change_page.text isEqualToString: @"下页"]){
                    _change_page.text = @"上页"; // switch the text
                    _sentence1a.hidden = true;
                    _sentence1b.hidden = true;
                    _sentence1c.hidden = true;
                    _sentence1d.hidden = true;
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
                    _sentence5d.hidden = false;
                    _sentence6a.hidden = false;
                    _sentence6b.hidden = false;
                    _sentence6c.hidden = false;
                    _sentence6d.hidden = false;
                    _sentence7a.hidden = false;
                    _sentence7b.hidden = false;
                    _sentence7c.hidden = false;
                    _sentence7d.hidden = false;
                    _sentence8a.hidden = false;
                    _sentence8b.hidden = false;
                    _sentence8c.hidden = false;
                    _sentence8d.hidden = false;
                    _sentence5.hidden = false;
                    _sentence6.hidden = false;
                    _sentence7.hidden= false;
                    _sentence8.hidden = false;
                    
                    
                    _sentence1.hidden = true;
                    _sentence2.hidden = true;
                    _sentence3.hidden= true;
                    _sentence4.hidden = true;
                    
                }
                
                else if ([_change_page.text isEqualToString: @"上页"]){
                    _change_page.text = @"下页"; // switch the text
                    _sentence1a.hidden = false;
                    _sentence1b.hidden = false;
                    _sentence1c.hidden = false;
                    _sentence1d.hidden = false;
                    _sentence2a.hidden = false;
                    _sentence2b.hidden = false;
                    _sentence2c.hidden = false;
                    _sentence2d.hidden = false;
                    _sentence3a.hidden = false;
                    _sentence3b.hidden = false;
                    _sentence3c.hidden = false;
                    _sentence3d.hidden = false;
                    _sentence4a.hidden = false;
                    _sentence4b.hidden = false;
                    _sentence4c.hidden = false;
                    _sentence4d.hidden = false;
                    
                    _sentence5a.hidden = true;
                    _sentence5b.hidden = true;
                    _sentence5c.hidden = true;
                    _sentence5d.hidden = true;
                    _sentence6a.hidden = true;
                    _sentence6b.hidden = true;
                    _sentence6c.hidden = true;
                    _sentence6d.hidden = true;
                    _sentence7a.hidden = true;
                    _sentence7b.hidden = true;
                    _sentence7c.hidden = true;
                    _sentence7d.hidden = true;
                    _sentence8a.hidden = true;
                    _sentence8b.hidden = true;
                    _sentence8c.hidden = true;
                    _sentence8d.hidden = true;
                    
                    _sentence5.hidden = true;
                    _sentence6.hidden = true;
                    _sentence7.hidden= true;
                    _sentence8.hidden = true;
                    
                    
                    _sentence1.hidden = false;
                    _sentence2.hidden = false;
                    _sentence3.hidden= false;
                    _sentence4.hidden = false;
                }
            }
            
            if( [node.name isEqualToString:@"go_back"]){
                
                for (UIView *subview in [self.view subviews]) {
                    
                    // if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    //  }
                }
                
                
                SKView *spriteView = (SKView *) self.view;
                Base_Scene *newScene = [Base_Scene sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
                
            }
            
            
            
            
            
            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            // Word Explanations BEGIN~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            if(([node.name isEqualToString:@"ta_m1"] || [node.name isEqualToString:@"ta_m2"]  || [node.name isEqualToString:@"ta_m3"] || [node.name isEqualToString:@"ta_m4"])&& (node.hidden == false) ) {
                [self show_chinese_translation:@"他" pinyin:@"tā" english:@"he" touch_loc:touchLocationInView ];
                
            }
            
            
            
            if(([node.name isEqualToString:@"ta_f1"] ||
                [node.name isEqualToString:@"ta_f2"] || [node.name isEqualToString:@"ta_f3"]|| [node.name isEqualToString:@"ta_f4"]) && (node.hidden == false)){
                [self show_chinese_translation:@"她" pinyin:@"tā" english:@"she" touch_loc:touchLocationInView ];
                
            }
            
            
            
            if (([node.name isEqualToString:@"shangwu1"] || [node.name isEqualToString:@"shangwu2"]
                 || [node.name isEqualToString:@"shangwu3"]) && (node.hidden!= false)){
                
                [self show_chinese_translation:@"上午" pinyin:@"shàngwǔ" english:@"(time:morning a.m.)" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"xiawu"] || [node.name isEqualToString:@"xiawu1"] || [node.name isEqualToString:@"xiawu2"]  ) && (node.hidden == false)){
                
                [self show_chinese_translation:@"下午" pinyin:@"xiàwǔ" english:@"(time:afternoon p.m.)" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"wanshang"]|| [node.name isEqualToString:@"wanshang1"]) && (node.hidden == false)){
                
                [self show_chinese_translation:@"晚上" pinyin:@"wǎnshàng" english:@"(time:night p.m.)" touch_loc:touchLocationInView ];
                
            }
            
            
            if (([node.name isEqualToString:@"qidianzhong"]) && (node.hidden == false)){
                [self show_chinese_translation:@"七点钟" pinyin:@"qī diǎn zhōng" english:@"7 o'clock" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"sandianban"]) && (node.hidden == false)){
                [self show_chinese_translation:@"三点半" pinyin:@"sān diǎn bàn" english:@"3:30" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"wudianban"]) && (node.hidden == false)){
                [self show_chinese_translation:@"五点半" pinyin:@"wǔ diǎn bàn" english:@"5:30" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"jiudianzhong"]) && (node.hidden== false)){
                [self show_chinese_translation:@"九点钟" pinyin:@"jiǔ diǎn zhōng" english:@"9 o'clock" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"sandianzhong"]) && (node.hidden == false)){
                [self show_chinese_translation:@"三点钟" pinyin:@"sān diǎn zhōng" english:@"3 o'clock" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"badian"] ) && (node.hidden== false)){
                
                [self show_chinese_translation:@"八点" pinyin:@"bā diǎn" english:@"8 o'clock" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"badian"] ) && (node.hidden== false)){
                
                [self show_chinese_translation:@"八点" pinyin:@"bā diǎn" english:@"8 o'clock" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"liangdian"] ) && (node.hidden== false)){
                
                [self show_chinese_translation:@"两点" pinyin:@"liǎng diǎn" english:@"2 o'clock" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"qidian"] ) && (node.hidden== false)){
                
                [self show_chinese_translation:@"七点" pinyin:@"qī diǎn" english:@"7 o'clock" touch_loc:touchLocationInView ];
                
            }
            
            if( ([node.name isEqualToString:@"wo0"] || [node.name isEqualToString:@"wo1"] || [node.name isEqualToString:@"wo2"] || [node.name isEqualToString:@"wo3"]|| [node.name isEqualToString:@"wo4"]|| [node.name isEqualToString:@"wo5"]) && (node.hidden== false)){
                [self show_chinese_translation:@"我" pinyin:@"wǒ" english:@"I" touch_loc:touchLocationInView ];
            }
            
            if (([node.name isEqualToString:@"kanshu"])  && (node.hidden== false) ){
                [self show_chinese_translation:@"看书" pinyin:@"kànshū" english:@"reads" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"paobu"] ) && (node.hidden== false)){
                
                [self show_chinese_translation:@"跑步" pinyin:@"pǎobù" english:@"runs" touch_loc:touchLocationInView ];
                
            }
            
            
            if (([node.name isEqualToString:@"tingyinyue"] || [node.name isEqualToString:@"tingyinyue1"]) && (node.hidden== false)){
                
                [self show_chinese_translation:@"听音乐" pinyin:@"tīng yīnyuè" english:@"listens to music" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"kandianshi" ]) && (node.hidden== false)){
                
                [self show_chinese_translation:@"看电视" pinyin:@"kàn diànshì" english:@"watches tv" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"chiwanfan"] ) && (node.hidden== false)){
                
                [self show_chinese_translation:@"吃晚饭" pinyin:@"chī wǎnfàn" english:@"eats dinner" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"tizuqiu"] ) && (node.hidden== false)){
                
                [self show_chinese_translation:@"踢足球" pinyin:@"tī zúqiú" english:@"plays soccer" touch_loc:touchLocationInView ];
                
            }
            
            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            // Word Explanations END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            
            
        }
    }
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end