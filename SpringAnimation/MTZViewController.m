//
//  MTZViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZViewController.h"

#import "MTZSpringAnimationParametersViewController.h"
#import "MTZSpringAnimationTranslateViewController.h"

@interface MTZViewController ()

/// The view controller housing the parameters of a spring animation.
@property (strong, nonatomic) MTZSpringAnimationParametersViewController *parametersVC;

/// The view controller housing the animations.
@property (strong, nonatomic) MTZSpringAnimationViewerController *animationsVC;

/// The subview for the animations view.
@property (weak, nonatomic) IBOutlet UIView *animationsView;
/// The subview for the parameters view.
@property (weak, nonatomic) IBOutlet UIView *parametersView;
/// The subview for the playback controls.
@property (weak, nonatomic) IBOutlet UIView *playBackControls;

@end

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Create parameters view controller.
	self.parametersVC = [[MTZSpringAnimationParametersViewController alloc] initWithNibName:@"MTZSpringAnimationParametersViewController" bundle:nil];
	// Add it to the appropriate container view.
	[self.parametersView addSubview:self.parametersVC.view];
	
	// Create animations view controller.
	self.animationsVC = [[MTZSpringAnimationTranslateViewController alloc] initWithNibName:@"MTZSpringAnimationTranslateViewController" bundle:nil];
	// Add it to the appropriate container view.
	[self.animationsView addSubview:self.animationsVC.view];
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
