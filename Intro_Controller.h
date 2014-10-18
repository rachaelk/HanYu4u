//
//  ViewController.h
//  HanYu4u
//

//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Base_Storyboard.h"


@interface Intro_Controller : UIViewController < MyDelegateProtocol>
{
    Base_Storyboard *_base_storyboard;
}
-(IBAction) switchToSecondPage;
@end
