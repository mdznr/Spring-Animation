//
//  MTZViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZViewController.h"

#import "MTZSpringAnimationParametersViewController.h"
#import "MTZSpringAnimationViewerController.h"

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

/// The different parameters of a spring animation.
typedef NS_ENUM(NSUInteger, MTZSpringAnimationParameter) {
	/// The duration of a spring animation.
	MTZSpringAnimationParameterDuration,
	/// The spring damping of a spring animation.
	MTZSpringAnimationParameterDamping,
	/// The initial velocity of a spring animation.
	MTZSpringAnimationParameterVelocity
};

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Create parameters view controller.
	self.parametersVC = [[MTZSpringAnimationParametersViewController alloc] initWithNibName:@"MTZSpringAnimationParametersViewController" bundle:nil];
	// Add it to the appropriate container view.
	[self.parametersView addSubview:self.parametersVC.view];
}

/*

/// Perfomed with "Test Spring Animation" button is tapped.
- (IBAction)testSpringAnimation:(id)sender
{
	// Ensure animation won't be interrupted by a pending reset (completion of a prior animation).
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(resetAnimatedViews) object:nil];
	
	// Start at the beginning.
	[self resetAnimatedViews];
	
	[UIView animateWithDuration:_durationSlider.value
						  delay:0.0f
		 usingSpringWithDamping:_dampingSlider.value
		  initialSpringVelocity:_velocitySlider.value
						options:0
					 animations:^{
						 _testView.transform = CGAffineTransformTranslate(_testView.transform, 320, 0);
					 }
					 completion:^(BOOL finished) {
						 [self performSelector:@selector(resetAnimatedViews) withObject:nil afterDelay:1.0f];
					 }];
}

- (void)resetAnimatedViews
{
	// Put the test view back where it belongs.
	_testView.transform = CGAffineTransformIdentity;
}
 
 */

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
