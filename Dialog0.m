//
//  Dialog0.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/21/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "Dialog0.h"

#import "Level0.h"

@implementation Dialog0
@synthesize input_hanyu0;
@synthesize user_input0;
@synthesize flashed_word0 = _flashed_word0;
@synthesize image_out0 = _image_out0;
@synthesize images;
@synthesize score0 = _score0;
@synthesize win = _win;
@synthesize incorrect = _incorrect;
@synthesize go_back = _go_back;
@synthesize customKeyboard = _customKeyboard;
@synthesize tap = _tap;


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

static inline int skRand(int low, int high){
    
    return arc4random()%(high-low) + low;//why no +1? high is already +1, of sorts.
                                   //high = length(array of nodes), and array is indexed [0,high-1].
                                   //so the count is (high-1)-low+1, or high-low.
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(SKSpriteNode*) shuffleHanyu:(int)ref len:(int)len array:(NSArray*) words{
    
    ref = skRand(0, len);
    SKSpriteNode *sprite = words[ref];
    if ([sprite.name isEqualToString:_flashed_word0]){
        ref = (ref + 1)%len;//go to next in 'stack' >>don't want to repeat
    }
    sprite = words[ref];
    sprite.hidden = false;
    [self.userData setValue:sprite.name forKey:@"image_index"]; //save flashed image's name
    
    //END INPUT INDICATOR:
    if(![user_input0 isEqualToString: @"end"]){
        //[self shuffleHanyu:ref len:len array:words];
        
    }
    return sprite;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-(void) check_word:(NSString*)input word:(NSString *) word {
    
    double current_score = [GameState sharedInstance].score;

    if ([_flashed_word0 isEqualToString: @"吃早饭"]){
        if([user_input0 isEqualToString: @"在吃早饭。"]
           || [user_input0 isEqualToString: @"他在吃早饭。"]
           || [user_input0 isEqualToString: @"他在吃早饭"]
           || [user_input0 isEqualToString: @"吃早饭"]
           || [user_input0 isEqualToString: @"他吃着早饭"]){
            _win.hidden = false;
            
            [GameState sharedInstance].score += 10 + [GameState sharedInstance].level_mod;
            [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
            input_hanyu0.text = @"";
            _image_out0.hidden = true;
            _image_out0 = [self shuffleHanyu:0 len:[self.images.children count] array:self.images.children];
            _image_out0.hidden= false;
        }
        else{
            input_hanyu0.text = @"";
             _incorrect.hidden = false;
        }
    
    }
    if ([_flashed_word0 isEqualToString: @"听音乐"]){
        if([user_input0 isEqualToString: @"在听音乐。"]
           || [user_input0 isEqualToString: @"他在听音乐。"]
           || [user_input0 isEqualToString: @"他在听音乐"]
           || [user_input0 isEqualToString: @"听音乐"]
           || [user_input0 isEqualToString: @"他听音乐"]){
            _win.hidden = false;
            
            [GameState sharedInstance].score += 10 + [GameState sharedInstance].level_mod;
            [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
            input_hanyu0.text = @"";
            _image_out0.hidden = true;
            _image_out0 = [self shuffleHanyu:0 len:[self.images.children count] array:self.images.children];
            _image_out0.hidden= false;
        }
        else{
            input_hanyu0.text = @"";
            _incorrect.hidden = false;
        }
    }
    
    if ([_flashed_word0 isEqualToString: @"看电视"]){
        if([user_input0 isEqualToString: @"在看电视。"]
           || [user_input0 isEqualToString: @"他在看电视。"]
           || [user_input0 isEqualToString: @"他在看电视"]
           || [user_input0 isEqualToString: @"看电视"]
           || [user_input0 isEqualToString: @"他看着电视"]){
            _win.hidden = false;
            
            [GameState sharedInstance].score += 10 + [GameState sharedInstance].level_mod;
            [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
            input_hanyu0.text = @"";
            _image_out0.hidden = true;
            _image_out0 = [self shuffleHanyu:0 len:[self.images.children count] array:self.images.children];
            _image_out0.hidden= false;
        }
        else{
            input_hanyu0.text = @"";
            _incorrect.hidden = false;
        }
    }
    
    if ([_flashed_word0 isEqualToString: @"喝咖啡"]){
        if([user_input0 isEqualToString: @"在喝咖啡。"]
           || [user_input0 isEqualToString: @"他在喝咖啡。"]
           || [user_input0 isEqualToString: @"他在喝咖啡"]
           || [user_input0 isEqualToString: @"喝咖啡"]
           || [user_input0 isEqualToString: @"他喝着咖啡"]){
            _win.hidden = false;
            
            [GameState sharedInstance].score += 10 + [GameState sharedInstance].level_mod ;
            [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
            input_hanyu0.text = @"";
            _image_out0.hidden = true;
            _image_out0 = [self shuffleHanyu:0 len:[self.images.children count] array:self.images.children];
            _image_out0.hidden= false;
        }
        else{
            input_hanyu0.text = @"";
            _incorrect.hidden = false;
        }
    }
    if ([_flashed_word0 isEqualToString: @"看书"]){
        if([user_input0 isEqualToString: @"在看书。"]
           || [user_input0 isEqualToString: @"他在看书。"]
           || [user_input0 isEqualToString: @"他在看书"]
           || [user_input0 isEqualToString: @"看书"]
           || [user_input0 isEqualToString: @"他看着书"]){
            _win.hidden = false;
            
            [GameState sharedInstance].score += 10 + [GameState sharedInstance].level_mod;
            [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
            input_hanyu0.text = @"";
            _image_out0.hidden = true;
            _image_out0 = [self shuffleHanyu:0 len:[self.images.children count] array:self.images.children];
            _image_out0.hidden= false;
        }
        else{
            input_hanyu0.text = @"";
            _incorrect.hidden = false;
        }
    }
    
    //IF don't do this, new _flashed_word0 will go through the other if statements
    if([GameState sharedInstance].score > current_score){
        //User was correct and received new flashcard. Update with the newly flashed word.
        _flashed_word0 = _image_out0.name;
    }
    
   
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)check_if_out{
    
    int num_im = [self.images.children count];
    if(!(self.view.scene.userData)){
        _image_out0.name = @"null";//<<<give starter name
        _image_out0 = [self shuffleHanyu:0 len:num_im array:self.images.children];
        _flashed_word0 = _image_out0.name;
        self.userData = [NSMutableDictionary dictionary];
        [self.userData setValue:_flashed_word0 forKey:@"image_index"];
    }
    else{
        _flashed_word0  = [self.userData valueForKey:@"image_index"];
        for(SKSpriteNode * child in self.images.children){
            if (child.name == _flashed_word0){
                child.hidden = false;
                _image_out0 = child; //set _image_out0 so that can hide it again later when user answers correctly
            }
        }
    }

}

-(void)dismissKeyboard{
    [input_hanyu0 resignFirstResponder];
}



-(id)initWithSize:( CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup */
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
   
        double padding = 0.2;
        
        
        images = [SKNode node];
        // Score
        //~~~~~~~~~~~~~~~~~~~~~
        _score0 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _score0.fontSize = 12;
        _score0.fontColor = [SKColor redColor];
        _score0.position = CGPointMake(self.frame.origin.x + 0.9*self.frame.size.width,self.frame.origin.y + 0.8*self.frame.size.height);
        [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
        [self addChild:_score0];
        
        //to be put next to score
        SKLabelNode *currency = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        currency.fontSize = 14;
        currency.fontColor = [SKColor redColor];
        [currency setText:@"RMB (快/元)"];
        currency.position = CGPointMake(0.5*(_score0.position.x + _score0.frame.size.width + self.frame.size.width),_score0.position.y);
        [self addChild:currency];
        
        
        SKLabelNode *intro = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        intro.name = @"intro";
        intro.text = @"他在做什么？";
        intro.fontSize = 12;
        intro.fontColor = [SKColor colorWithRed:1 green:1 blue:0 alpha:1];
        intro.position = CGPointMake(CGRectGetMidX(self.frame), _score0.position.y);
        [self addChild:intro];
        
        //dialog controller~~~~~~~~~~~~
        _go_back = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _go_back.name = @"go_back";
        _go_back.text = @"Go Back";
        
        _go_back.fontSize = 12;
        _go_back.fontColor = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
        _go_back.position = CGPointMake(CGRectGetMinX(self.frame)+50, CGRectGetMinY(self.frame)+30);
        SKSpriteNode *button_page = [SKSpriteNode spriteNodeWithImageNamed:@"blue_button"];
        button_page.xScale = 0.35;
        button_page.yScale = 0.6;
        button_page.position = CGPointMake(_go_back.position.x,_go_back.position.y+ padding * _go_back.frame.size.height);
        
        [self addChild:button_page];
        [self addChild: _go_back];
        //~~~~~~~~~~~~~~~~dialog controller
        
        
        SKLabelNode *help = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        help.name = @"help";
        help.text = @"请帮助我";
        help.fontSize = 12;
        help.fontColor = [SKColor colorWithRed:1 green:0.1 blue:0 alpha:1];
        help.position = CGPointMake(CGRectGetMinX(self.frame)+30, _score0.position.y-20);
        [self addChild:help];
        
        SKSpriteNode *bfast_man = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/cereal_man"];
        [bfast_man setScale:0.25];
        bfast_man.name = @"吃早饭";
        bfast_man.hidden = true;

        SKSpriteNode *kafei_man = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/hekafei"];
        [kafei_man setScale:0.28];
        kafei_man.name = @"喝咖啡";
        kafei_man.hidden = true;
        
        SKSpriteNode *music_man = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/music"];
        [music_man setScale:0.2];
        music_man.name = @"听音乐";
        music_man.hidden = true;
        
        SKSpriteNode *tv_man = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/tv"];
        [tv_man setScale:0.2];
        tv_man.name = @"看电视";
        tv_man.hidden = true;
        
        
        SKSpriteNode *book_man = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/kanshu"];
        [book_man setScale:0.3];
        book_man.name = @"看书";
        book_man.hidden = true;
        
        bfast_man.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-140);
        kafei_man.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-140);
        music_man.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-140);
        tv_man.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-140);
        book_man.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-140);
        
        [images addChild:bfast_man];
        [images addChild:kafei_man];
        [images addChild:music_man];
        [images addChild:tv_man];
        [images addChild:book_man];
        [self addChild:images];
        
        
        _win = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _win.text = @"对！Correct!";
        _win.fontSize = 12;
        _win.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40);
        _win.hidden = true;
        [self addChild:_win];
        _incorrect = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
        _incorrect.text = @"不对 incorrect 再试试吧";
        _incorrect.fontSize = 12;
        _incorrect.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40);
        _incorrect.hidden = true;
        [self addChild:_incorrect];


    }
    return self;
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-(void)didMoveToView:(SKView *)view {


    //SET Keyboard for the lesson:
    
    NSMutableArray *k =[[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"咖", @"视", @"乐", @"吃", @"看", @" ",  @" ",  @" ", @" ", @" ", @"书", @"早", @"音", @"电", @"听", @"他", @"我", @" ", @" ", @" ", @"啡", @"饭", @"你", @"在", @"喝", @"。", @" ", nil];
    
     NSMutableArray *kshift = [[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"咖", @"视", @"乐", @"吃", @"看", @" ",  @" ",  @" ", @" ", @" ", @"书", @"早", @"音", @"电", @"听", @"他", @"我", @" ", @" ", @" ", @"啡", @"饭", @"你", @"在", @"喝", @"。", @" ", nil];

     NSMutableArray *kalt = [[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"咖", @"视", @"乐", @"吃", @"看", @" ",  @" ",  @" ", @" ", @" ", @"书", @"早", @"音", @"电", @"听", @"他", @"我", @" ", @" ", @" ", @"啡", @"饭", @"你", @"在", @"喝", @"。", @" ", nil];
    
    [GameState sharedInstance].keyboard_characters = k;
    [GameState sharedInstance].keyboard_characters_shift = kshift;
    [GameState sharedInstance].keyboard_characters_alt = kalt;
    
    
    _customKeyboard = [[PMCustomKeyboard alloc] init];

    input_hanyu0 = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width/4,(self.frame.size.height/3+250)/2, 150, 30)];
    input_hanyu0.borderStyle = UITextBorderStyleRoundedRect;
    input_hanyu0.textColor = [UIColor blackColor];
    input_hanyu0.font = [UIFont systemFontOfSize:12.0];
    input_hanyu0.placeholder = @"回答吧!加油";
    input_hanyu0.backgroundColor = [UIColor whiteColor];
    input_hanyu0.autocorrectionType = UITextAutocorrectionTypeNo;
    input_hanyu0.tag = 9;
    input_hanyu0.clearButtonMode = UITextFieldViewModeWhileEditing;
    [input_hanyu0 setDelegate:self];
    [input_hanyu0 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    [_customKeyboard setTextView:input_hanyu0];

    //the following block makes it such that tapping outside the textfield dismisses the keyboard~~~
    [self.view addSubview:input_hanyu0];

    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    _tap.numberOfTapsRequired = 2; //if this is not specified, computer gets confused-- can't tell what is purposeful click
    [self.view addGestureRecognizer:_tap];
    
    
    [self check_if_out];
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


//works:
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        CGPoint touchLocationInView = [touch locationInView:self.scene.view];
        
        for (SKNode *node in nodes) {
            
            
            if( [node.name isEqualToString:@"go_back"]){
                   
                for (UIView *subview in [self.view subviews]) {
                    // Only remove the subviews with tag not equal to 1
                    if (subview.tag == 7 || subview.tag == 9) {
                        [subview removeFromSuperview];
                   }
                }
                [self.view removeGestureRecognizer:_tap];
                _tap = nil;
                SKView *spriteView = (SKView *) self.view;
                SKScene *currentScene = [spriteView scene];
                Level0 *newScene = [Level0 sceneWithSize:spriteView.bounds.size];
                if(!currentScene.userData){
                    [spriteView presentScene:newScene];
                }
                else{
                    newScene.userData = [NSMutableDictionary dictionary];
                    [newScene.userData setObject:[currentScene.userData objectForKey:@"image_index"] forKey:@"image_index"];
                    [spriteView presentScene:newScene];
                }
                
            }
            
            
            
            
            if( [node.name isEqualToString:@"help"]){
                
                for (UIView *subview in [self.view subviews]) {
                    // Only remove the subviews with tag not equal to 1
                    if (subview.tag == 7) {
                        [subview removeFromSuperview];
                    }
                }
                
                UILabel *explanationField = [[UILabel alloc] initWithFrame:self.frame];
                [explanationField setFont:[UIFont fontWithName:@"EuphemiaUCAS-Bold" size:8.0f]];
                explanationField.textColor=[UIColor whiteColor];
                explanationField.backgroundColor=[UIColor blackColor];
                explanationField.alpha = 0.8;
                
                NSString *start= @"他在~";
                
                int n = sizeof(_flashed_word0);
                int k = 6 % (n);//ensures in range of string
                NSString *add =  [_flashed_word0 substringWithRange:NSMakeRange(k,1)];
                NSString *helper=[NSString stringWithFormat:@"%@%@",start, add];
                explanationField.text = helper;
                
                CGPoint mid = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
                explanationField.adjustsFontSizeToFitWidth = true;
                explanationField.lineBreakMode = false;
                explanationField.textAlignment = NSTextAlignmentCenter;
                CGPoint positionInScene = touchLocationInView;
                
                CGFloat xPosition = positionInScene.x - 0.05*(positionInScene.x + mid.x);
                CGFloat yPosition = positionInScene.y + 0.04*(positionInScene.y + mid.y) ;
                
                CGRect labelFrame = explanationField.frame;
                [explanationField adjustsFontSizeToFitWidth ];
                explanationField.frame = labelFrame;
                [explanationField sizeToFit];
                
                CGRect frame = explanationField.frame;
                frame.origin.y= yPosition;//pass the cordinate which you want
                frame.origin.x= xPosition;//pass the cordinate which you want
                explanationField.frame = frame;
                
                
                explanationField.layer.borderColor = [UIColor redColor].CGColor;
                explanationField.layer.borderWidth = 1.0;
                explanationField.tag = 7;
                
                
                [self.view addSubview:explanationField];
                
            }
        }
    }
    
    
    
    
    
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    user_input0 = textField.text;
    [self check_word:user_input0 word:_flashed_word0];
    [textField resignFirstResponder];
    return YES;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-(BOOL)textFieldDidEndEditing:(UITextField *)textField
{
    user_input0 = textField.text;
    [textField resignFirstResponder];
    return YES;
}



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    _win.hidden = true;
    _incorrect.hidden = true;
    user_input0 = @"";
    return YES;

    
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(BOOL)textFieldDidChange:(UITextField *)textField
{
    _win.hidden = true;
    _incorrect.hidden = true;
    return YES;
    
    
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    _win.hidden = true;
    _incorrect.hidden = true;
    return YES;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



@end
