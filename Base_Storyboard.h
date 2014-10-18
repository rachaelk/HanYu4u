//
//  Base_Storyboard.h
//  HanYu4u
//
//  Created by Rachael Keller on 7/18/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "PMCustomKeyboard.h"


//protocol unecessary, but there if desired.
@protocol MyDelegateProtocol <NSObject>
-(IBAction)switchToSecondPage;
@end

@interface Base_Storyboard : UIViewController
{
    id<MyDelegateProtocol> delegate;
}
@property (retain) id delegate;


- (IBAction)switchToLevel0;
- (IBAction)switchToDialog0;
- (IBAction)switchToLevel1;
- (IBAction)switchToLevel2;
- (IBAction)switchToLevel3;


@end
