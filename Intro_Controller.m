//
//  ViewController.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/18/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "Intro_Controller.h"
#import "MyScene.h"



@implementation Intro_Controller



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.introViewController = self;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (IBAction)switchToSecondPage
{
    NSLog(@"tide is hiiiigh~~");
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Base_Storyboard *base_storyboard = [sb instantiateViewControllerWithIdentifier:@"Base_Storyboard"];
    base_storyboard.delegate = self;
    
    [self.navigationController pushViewController: base_storyboard animated:YES ];
    
    
}
/* //UNECESSARY:
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewDidAppear:animated];
}
*/
- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end



