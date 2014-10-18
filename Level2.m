//
//  Level2.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/19/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "Level2.h"
#import "Dialog2.h"
#import "Base_Scene.h"
#import <UIKit/UIKit.h>

@implementation Level2
@synthesize lblScore = _lblScore;
@synthesize dialog_start02 = _dialog_start02;
@synthesize go_back = _go_back;
@synthesize change_page = _change_page;

@synthesize sentence1a = _sentence1a;
@synthesize sentence1b = _sentence1b;
@synthesize sentence1c = _sentence1c;

@synthesize sentence2a = _sentence2a;
@synthesize sentence2b = _sentence2b;
@synthesize sentence2c = _sentence2c;

@synthesize sentence3a = _sentence3a;
@synthesize sentence3b = _sentence3b;
@synthesize sentence3c = _sentence3c;

@synthesize sentence4a = _sentence4a;
@synthesize sentence4b = _sentence4b;
@synthesize sentence4c = _sentence4c;

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
        /*
        _dialog_start02 = [SKLabelNode  labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _dialog_start02.name = @"dialog_start02";
        _dialog_start02.fontSize = 8;
        _dialog_start02.text = @"给我小考试吧！Quiz~";
        
        _dialog_start02.fontSize = 12;
        _dialog_start02.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _dialog_start02.position = CGPointMake(CGRectGetMinX(self.frame)+80, CGRectGetMinY(self.frame)+50);
        _dialog_start02.zPosition = 1; //sets it on foreground
        
        SKSpriteNode *button_dialog = [SKSpriteNode spriteNodeWithImageNamed:@"blue_button"];
        button_dialog.xScale = 0.7;
        button_dialog.yScale = 0.6;
        button_dialog.position = CGPointMake(_dialog_start02.position.x,_dialog_start02.position.y+ padding *_dialog_start02.frame.size.height);
        
        [self addChild: _dialog_start02];
        [self addChild:button_dialog];
        */
        //~~~~~~~~~~~~~~~~dialog controller
        //previous_page controller~~~~~~~~~~~~
        _go_back = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _go_back.name = @"go_back";
        _go_back.fontSize = 12;
        _go_back.text = @"Go Back";
        _go_back.zPosition = 1; //set on foreground
        _go_back.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        _go_back.position = CGPointMake(CGRectGetMinX(self.frame)+80, CGRectGetMinY(self.frame)+50);
        SKSpriteNode *button_scene = [SKSpriteNode spriteNodeWithImageNamed:@"blue_button"];
        button_scene.xScale = 0.35;
        button_scene.yScale = 0.6;
        button_scene.position = CGPointMake(_go_back.position.x,_go_back.position.y+ padding * _go_back.frame.size.height);
        
        [self addChild: _go_back];
        [self addChild:button_scene];
        //~~~~~~~~~~~~~~~~previous_page controller
        
        
        _change_page = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
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
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Chinese Words~~~~~~~~~~~~~~~~~~~~~~~
        int max_buffer_c0 = 0;
        int max_buffer_c1 = 0;
        int max_buffer_c2 = 0;
        
        float buffer = 1.85;
        
        
        SKLabelNode *ni0 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        ni0.name = @"ni0";
        ni0.text = @"你";
        ni0.fontSize = 14;
        ni0.fontColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1];
        ni0.position = CGPointMake(CGRectGetMinX(self.frame)+30, _lblScore.position.y);
        
        SKLabelNode *zenmeyang = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        zenmeyang.name = @"zenmeyang";
        zenmeyang.text = @"怎么样？";
        zenmeyang.fontSize = 14;
        zenmeyang.fontColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1];
        zenmeyang.position = CGPointMake((ni0.position.x)+42,
                                         ni0.position.y);
        
        
        
        
        _sentence1a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1a.name = @"wo1";
        _sentence1a.text = @"我";
        if(_sentence1a.text.length > max_buffer_c0){max_buffer_c0 =(int) _sentence1a.text.length;}
        _sentence1a.fontSize = 14;
        _sentence1a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence1b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1b.name = @"hen1";
        _sentence1b.text = @"很";
        if(_sentence1b.text.length > max_buffer_c1){max_buffer_c1 =(int) _sentence1b.text.length;}
        _sentence1b.fontSize = 14;
        _sentence1b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence1c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence1c.name = @"lei";
        _sentence1c.text = @"累。";
        if(_sentence1c.text.length > max_buffer_c2){max_buffer_c2 =(int) _sentence1c.text.length;}
        _sentence1c.fontSize = 14;
        _sentence1c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        SKSpriteNode *bfast_man = [SKSpriteNode spriteNodeWithImageNamed:@"cereal_man"];
        [bfast_man setScale:0.25];
        
        
        _sentence2a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2a.name = @"wo2";
        _sentence2a.text = @"我";
        if(_sentence2a.text.length > max_buffer_c0){max_buffer_c0 =(int) _sentence2a.text.length;}
        _sentence2a.fontSize = 14;
        _sentence2a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        _sentence2b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2b.name = @"hen2";
        _sentence2b.text = @"很";
        _sentence2b.fontSize = 14;
        if(_sentence1b.text.length > max_buffer_c1){max_buffer_c1 =(int) _sentence2b.text.length;}

        _sentence2b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence2c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence2c.name = @"mang";
        _sentence2c.text = @"忙。";
        if(_sentence2c.text.length > max_buffer_c2){max_buffer_c2 =(int) _sentence2c.text.length;}
        _sentence2c.fontSize = 14;
        _sentence2c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        SKSpriteNode *kafei_man = [SKSpriteNode spriteNodeWithImageNamed:@"hekafei"];
        [kafei_man setScale:0.28];
        
        
        _sentence3a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3a.name = @"wo3";
        _sentence3a.text = @"我";
        if(_sentence3a.text.length > max_buffer_c0){max_buffer_c0 =(int) _sentence3a.text.length;}
        _sentence3a.fontSize = 14;
        _sentence3a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence3b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3b.name = @"hen3";
        _sentence3b.text = @"很";
        _sentence3b.fontSize = 14;
        _sentence3b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence3c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence3c.name = @"gaoxing";
        _sentence3c.text = @"高兴";
        _sentence3c.fontSize = 14;
        if(_sentence3c.text.length > max_buffer_c2){max_buffer_c2 = (int)_sentence3c.text.length;}
        _sentence3c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        
        SKSpriteNode *music_man = [SKSpriteNode spriteNodeWithImageNamed:@"music"];
        [music_man setScale:0.2];
        
        
        
        _sentence4a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4a.name = @"wo4";
        _sentence4a.text = @"我";
        if(_sentence4a.text.length > max_buffer_c0){max_buffer_c0 = (int)_sentence4a.text.length;}
        _sentence4a.fontSize = 14;
        _sentence4a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        
        _sentence4b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4b.name = @"hen4";
        _sentence4b.text = @"很";
        if(_sentence4b.text.length > max_buffer_c1){max_buffer_c1 = (int)_sentence4b.text.length;}
        _sentence4b.fontSize = 14;
        _sentence4b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        
        _sentence4c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence4c.name = @"e";
        _sentence4c.text = @"饿！";
        _sentence4c.fontSize = 14;
        _sentence4c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        
        
         //NEXT PAGE~~
        
        _sentence5a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5a.name = @"wo5";
        _sentence5a.text = @"我";
        _sentence5a.fontSize = 14;
        if(_sentence5a.text.length > max_buffer_c0){max_buffer_c0 = (int)_sentence5a.text.length;}
        _sentence5a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence5b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5b.name = @"bu";
        _sentence5b.text = @"不";
        if(_sentence5b.text.length > max_buffer_c1){max_buffer_c1 = (int)_sentence5b.text.length;}
        _sentence5b.fontSize = 14;
        _sentence5b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence5c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence5c.name = @"shufu";
        _sentence5c.text = @"舒服。";
        if(_sentence5c.text.length > max_buffer_c2){max_buffer_c2 = (int)_sentence5c.text.length;}
        _sentence5c.fontSize = 14;
        _sentence5c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        SKSpriteNode *book_man = [SKSpriteNode spriteNodeWithImageNamed:@"kanshu"];
        book_man.position = CGPointMake((CGRectGetMaxX(self.frame)+_sentence5c.position.x)/2, _sentence5c.position.y);
        [book_man setScale:0.3];
        
       
        
        _sentence6a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6a.name = @"nage";
        _sentence6a.text = @"那个";
        _sentence6a.fontSize = 14;
        if(_sentence6a.text.length > max_buffer_c0){max_buffer_c0 = (int)_sentence6a.text.length;}
        _sentence6a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence6b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6b.name = @"hen6";
        _sentence6b.text = @"很";
        if(_sentence6b.text.length > max_buffer_c1){max_buffer_c1 =(int) _sentence6b.text.length;}
        _sentence6b.fontSize = 14;
        _sentence6b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence6c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence6c.name = @"pianyi";
        _sentence6c.text = @"便宜。";
        if(_sentence6c.text.length > max_buffer_c2){max_buffer_c2 =(int) _sentence6c.text.length;}
        _sentence6c.fontSize = 14;
        _sentence6c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        
        _sentence7a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7a.name = @"zhege1";
        _sentence7a.text = @"这个";
        _sentence7a.fontSize = 14;
        if(_sentence7a.text.length > max_buffer_c0){max_buffer_c0 = (int)_sentence7a.text.length;}
        _sentence7a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence7b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7b.name = @"hen7";
        _sentence7b.text = @"不太";
        if(_sentence7b.text.length > max_buffer_c1){max_buffer_c1 =(int) _sentence7b.text.length;}
        _sentence7b.fontSize = 14;
        _sentence7b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence7c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence7c.name = @"gui";
        _sentence7c.text = @"贵。";
        if(_sentence7c.text.length > max_buffer_c2){max_buffer_c2 =(int) _sentence7c.text.length;}
        _sentence7c.fontSize = 14;
        _sentence7c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        _sentence8a = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8a.name = @"wo8";
        _sentence8a.text = @"我";
        _sentence8a.fontSize = 14;
        if(_sentence8a.text.length > max_buffer_c0){max_buffer_c0 = (int) _sentence7a.text.length;}
        _sentence8a.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        
        
        _sentence8b = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8b.name = @"butai1";
        _sentence8b.text = @"不太";
        if(_sentence8b.text.length > max_buffer_c1){max_buffer_c1 = (int) _sentence7b.text.length;}
        _sentence8b.fontSize = 14;
        _sentence8b.fontColor = [SKColor colorWithRed:0 green:1 blue:0 alpha:1];
        
        _sentence8c = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _sentence8c.name = @"hao";
        _sentence8c.text = @"好。";
        if( _sentence8c.text.length > max_buffer_c2){max_buffer_c2 =  (int)_sentence7c.text.length;}
        _sentence8c.fontSize = 14;
        _sentence8c.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
        
        
        
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Chinese Words end

        NSMutableString *string_pad0 = [[NSMutableString alloc]init];
        NSMutableString *string_pad1 = [[NSMutableString alloc]init];
        NSString *space = @"啊";
        for (int i = 0; i <= max_buffer_c0+2; ++i){ [string_pad0 appendString:space];}
        for (int i = 0; i <= max_buffer_c1+2; ++i){ [string_pad1 appendString:space];}
        
        SKLabelNode *pad0 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        pad0.name = @"pad0";
        pad0.text = string_pad0;
        pad0.fontSize = 14;
        SKLabelNode *pad1 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        pad1.name = @"pad1";
        pad1.text = string_pad1;
        pad1.fontSize = 14;
        //~~~~~~~~~~~~~~~~~~~~~~~~~Chinese words end
        
        _sentence1a.position = CGPointMake(ni0.position.x + 20, ni0.position.y-70);
        _sentence1b.position = CGPointMake((_sentence1a.position.x) + abs(buffer* _sentence1a.frame.size.width - pad0.frame.size.width), _sentence1a.position.y);
        _sentence1c.position = CGPointMake((_sentence1b.position.x)+ 0.5*_sentence1b.frame.size.width+ abs(buffer* _sentence1b.frame.size.width - pad1.frame.size.width), _sentence1a.position.y);
        
        _sentence2a.position = CGPointMake(_sentence1a.position.x,  _sentence1a.position.y-(bfast_man.size.height) - 10);
        _sentence2b.position = CGPointMake(_sentence1b.position.x, _sentence2a.position.y);
        _sentence2c.position = CGPointMake(_sentence1c.position.x,_sentence2a.position.y);
        
        _sentence3a.position = CGPointMake(_sentence2a.position.x, _sentence2a.position.y-(kafei_man.size.height) - 10);
        _sentence3b.position = CGPointMake(_sentence1b.position.x, _sentence3a.position.y);
        _sentence3c.position = CGPointMake(_sentence1c.position.x, _sentence3a.position.y);
        
        _sentence4a.position = CGPointMake(_sentence3a.position.x, _sentence3a.position.y-(music_man.size.height) - 10);
        _sentence4b.position = CGPointMake(_sentence1b.position.x, _sentence4a.position.y);
        _sentence4c.position = CGPointMake(_sentence1c.position.x, _sentence4a.position.y);
        
        //NEXT PAGE~~~
        _sentence5a.position = CGPointMake(_sentence1a.position.x, _sentence1b.position.y);
        _sentence5b.position = CGPointMake(_sentence1b.position.x,_sentence5a.position.y);
        _sentence5c.position = CGPointMake(_sentence1c.position.x, _sentence5a.position.y);
        
        _sentence6a.position = CGPointMake(_sentence2a.position.x, _sentence2a.position.y);
        _sentence6b.position = CGPointMake(_sentence1b.position.x,_sentence2b.position.y);
        _sentence6c.position = CGPointMake(_sentence1c.position.x, _sentence2c.position.y);
        
        
        _sentence7a.position = CGPointMake(_sentence3a.position.x, _sentence3a.position.y);
        _sentence7b.position = CGPointMake(_sentence1b.position.x,_sentence3b.position.y);
        _sentence7c.position = CGPointMake(_sentence1c.position.x, _sentence3c.position.y);
        
        _sentence8a.position = CGPointMake(_sentence4a.position.x, _sentence4a.position.y);
        _sentence8b.position = CGPointMake(_sentence1b.position.x,_sentence4b.position.y);
        _sentence8c.position = CGPointMake(_sentence1c.position.x, _sentence4c.position.y);
        
        
        
        //add nodes begin~~~~
        [self addChild:music_man];
        [self addChild:_sentence1a];
        [self addChild:_sentence1b];
        [self addChild:_sentence1c];
        [self addChild:_sentence2a];
        [self addChild:_sentence2b];
        [self addChild:_sentence2c];
        [self addChild:_sentence3a];
        [self addChild:_sentence3b];
        [self addChild:_sentence3c];
        [self addChild:_sentence4a];
        [self addChild:_sentence4b];
        [self addChild:_sentence4c];
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
    _sentence1b.hidden = false;
    _sentence1c.hidden = false;
    
    _sentence2a.hidden = false;
    _sentence2b.hidden = false;
    _sentence2c.hidden = false;
    
    _sentence3a.hidden = false;
    _sentence3b.hidden = false;
    _sentence3c.hidden = false;
    
    _sentence4a.hidden = false;
    _sentence4b.hidden = false;
    _sentence4c.hidden = false;
    
    _sentence5a.hidden = true;
    _sentence5b.hidden = true;
    _sentence5c.hidden = true;
    
    _sentence6a.hidden = true;
    _sentence6b.hidden = true;
    _sentence6c.hidden = true;
    
    _sentence7a.hidden = true;
    _sentence7b.hidden = true;
    _sentence7c.hidden = true;
    
    _sentence8a.hidden = true;
    _sentence8b.hidden = true;
    _sentence8c.hidden = true;
    
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        CGPoint touchLocationInView = [touch locationInView:self.scene.view];
        
        for (SKNode *node in nodes) {
            
            
            if( [node.name isEqualToString:@"dialog_start02"]){
                
                for (UIView *subview in [self.view subviews]) {
                    // Only remove the subviews with tag not equal to 7 <<not for new load
                    if (subview.tag == 9 || subview.tag == 7) {
                        [subview removeFromSuperview];
                    }
                }
                
                SKView *spriteView = (SKView *) self.view;
                SKScene *currentScene = [spriteView scene];
                Dialog2 *newScene = [Dialog2 sceneWithSize:spriteView.bounds.size];
                
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
                
                if([_change_page.text isEqualToString: @"下页"]){
                    _change_page.text = @"上页"; //switch the text
                    _sentence1a.hidden = true;
                    _sentence1b.hidden = true;
                    _sentence1c.hidden = true;

                    _sentence2a.hidden = true;
                    _sentence2b.hidden = true;
                    _sentence2c.hidden = true;

                    _sentence3a.hidden = true;
                    _sentence3b.hidden = true;
                    _sentence3c.hidden = true;
                   
                    _sentence4a.hidden = true;
                    _sentence4b.hidden = true;
                    _sentence4c.hidden = true;
                    
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
                    
                }
                
                else if ([_change_page.text isEqualToString: @"上页"]){
                    _change_page.text = @"下页"; //switch the text
                    _sentence1a.hidden = false;
                    _sentence1b.hidden = false;
                    _sentence1c.hidden = false;
                    
                    _sentence2a.hidden = false;
                    _sentence2b.hidden = false;
                    _sentence2c.hidden = false;
                    
                    _sentence3a.hidden = false;
                    _sentence3b.hidden = false;
                    _sentence3c.hidden = false;
                    
                    _sentence4a.hidden = false;
                    _sentence4b.hidden = false;
                    _sentence4c.hidden = false;
                    
                    _sentence5a.hidden = true;
                    _sentence5b.hidden = true;
                    _sentence5c.hidden = true;
                   
                    _sentence6a.hidden = true;
                    _sentence6b.hidden = true;
                    _sentence6c.hidden = true;
                    
                    _sentence7a.hidden = true;
                    _sentence7b.hidden = true;
                    _sentence7c.hidden = true;
                    
                    _sentence8a.hidden = true;
                    _sentence8b.hidden = true;
                    _sentence8c.hidden = true;
                    
                }
            }
            
            
            
            
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //Word Explanations BEGIN~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            if([node.name isEqualToString:@"ni0"]) {
                [self show_chinese_translation:@"你" pinyin:@"nǐ" english:@"you" touch_loc:touchLocationInView ];
                
            }
            
            
            
            if ([node.name isEqualToString:@"zaizuo"]){
                
                [self show_chinese_translation:@"在做" pinyin:@"zàizuò" english:@"am doing" touch_loc:touchLocationInView ];
                
            }
            
            
            
            
            if ([node.name isEqualToString:@"shenme"]){
                [self show_chinese_translation:@"什么" pinyin:@"shénme" english:@"what" touch_loc:touchLocationInView ];
                
            }
            
            
            if ([node.name isEqualToString:@"nage"]){
                
                [self show_chinese_translation:@"那个" pinyin:@"nàgè" english:@"that" touch_loc:touchLocationInView ];
                
            }
            if ([node.name isEqualToString:@"zhege"]){
                
                [self show_chinese_translation:@"这个" pinyin:@"zhège" english:@"this" touch_loc:touchLocationInView ];
                
            }
            
            if ([node.name isEqualToString:@"pianyi"]){
                
                [self show_chinese_translation:@"便宜" pinyin:@"piányí" english:@"cheap" touch_loc:touchLocationInView ];
                
            }
            if ([node.name isEqualToString:@"gui"]){
                
                [self show_chinese_translation:@"贵" pinyin:@"guì" english:@"expensive" touch_loc:touchLocationInView ];
                
            }
            
            if (([node.name isEqualToString:@"wo1"] || [node.name isEqualToString:@"wo2"] || [node.name isEqualToString:@"wo3"]|| [node.name isEqualToString:@"wo4"] || [node.name isEqualToString:@"wo5"]|| [node.name isEqualToString:@"wo6"] || [node.name isEqualToString:@"wo7"]|| [node.name isEqualToString:@"wo8"])&& (node.hidden == false)){
                [self show_chinese_translation:@"我" pinyin:@"wǒ" english:@"I" touch_loc:touchLocationInView ];
            }
            if (([node.name isEqualToString:@"hen4"] || [node.name isEqualToString:@"hen1"] || [node.name isEqualToString:@"hen2"] || [node.name isEqualToString:@"hen3"] || [node.name isEqualToString:@"hen6"] || [node.name isEqualToString:@"hen7"])&& (node.hidden == false)){
                [self show_chinese_translation:@"很" pinyin:@"hěn" english:@"(mild) very" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"bu"] || [node.name isEqualToString:@"bu1"] )&& (node.hidden == false)){
                [self show_chinese_translation:@"不" pinyin:@"bù" english:@"not" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"butai"] || [node.name isEqualToString:@"butai1"] )&& (node.hidden == false)){
                [self show_chinese_translation:@"不太" pinyin:@"bù tài" english:@"not really" touch_loc:touchLocationInView ];
                
            }
            
            
            if (([node.name isEqualToString:@"lei"]  )&& (node.hidden == false)){
                [self show_chinese_translation:@"累" pinyin:@"lèi" english:@"tired" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"mang"] || [node.name isEqualToString:@"mang1"] )&& (node.hidden == false)){
                [self show_chinese_translation:@"忙" pinyin:@"máng" english:@"busy" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"gaoxing"]  )&& (node.hidden == false)){
                [self show_chinese_translation:@"高兴" pinyin:@"gāoxìng" english:@"happy" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"e1"]   || [node.name isEqualToString:@"e"] )&& (node.hidden == false)){
                [self show_chinese_translation:@"饿" pinyin:@"è" english:@"hungry" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"shufu"]  )&& (node.hidden == false)){
                [self show_chinese_translation:@"舒服" pinyin:@"shūfú" english:@"comfortable (feel well)" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"zaikan1"]  )&& (node.hidden == false)){
                [self show_chinese_translation:@"在看" pinyin:@"zài kàn" english:@"am watching" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"zaikan1"]  )&& (node.hidden == false)){
                [self show_chinese_translation:@"在看" pinyin:@"zài kàn" english:@"am watching" touch_loc:touchLocationInView ];
                
            }
            if (([node.name isEqualToString:@"hao"]  )&& (node.hidden == false)){
                [self show_chinese_translation:@"好" pinyin:@"hǎo" english:@"good (well)" touch_loc:touchLocationInView ];
                
            }
            
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //Word Explanations END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            
            
        }
    }
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end