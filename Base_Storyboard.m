//
//  Base_Storyboard.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/18/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "Base_Storyboard.h"
#import "Base_Scene.h"

#import "Level0.h"
#import "Dialog0.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"

@implementation Base_Storyboard

@synthesize delegate;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Configure the view.
    NSLog(@"FERNANDO!2");
    SKView * skView = (SKView *)self.view;
    //skView.showsFPS = YES; //just have this on so that I know we switched ViewControllers
    

    // Create and configure the scene.
    Base_Scene *scene2 = [Base_Scene sceneWithSize:skView.bounds.size];
    scene2.scaleMode = SKSceneScaleModeAspectFill;
    //scene2.baseViewController = self;
    // Present the scene.
    [skView presentScene:scene2];
}




- (IBAction)switchToLevel0
{
    
    SKView * skView_temp = (SKView *)self.view;
    NSLog(@"tide is hiiiigh~~");
    Level0 *scene0 = [Level0 sceneWithSize:skView_temp.bounds.size];
     NSLog(@"tide is hiiiigh~~1");
    scene0.scaleMode = SKSceneScaleModeAspectFill;
    //scene0.root_controller = self;
    // Present the scene.
    [skView_temp presentScene:scene0];
}




-(IBAction)switchToDialog0
{
    NSLog(@"hi");
    SKView * skView_temp = (SKView *)self.view;
    Dialog0 *scene = [Dialog0 sceneWithSize:skView_temp.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    //scene.root_controller = self;
    // Present the scene.
    [skView_temp presentScene:scene];

    
}

- (IBAction)switchToLevel1
{
    NSLog(@"tide is hiiiigh~~");
    
}

- (IBAction)switchToLevel2
{
    NSLog(@"tide is hiiiigh~~");
    
}
- (IBAction)switchToLevel3
{
    NSLog(@"tide is hiiiigh~~");
     
    
}




/* UNECESSARY: viewDidLoad is called when use UIStoryboard method to access Base_Storyboard. Else need.
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"FERNANDO1");
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene *scene2 = [MyScene sceneWithSize:skView.bounds.size];
    scene2.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene2];
}
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
