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
#import "MTZSpringAnimationRotateViewController.h"
#import "MTZAnimationSelectTableViewController.h"

@interface MTZViewController () <MTZAnimationSelectTableViewControllerDelgate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

/// The table view controller for selecting the animation (appears in a popover).
@property (strong, nonatomic) MTZAnimationSelectTableViewController *animationsList;

/// The popover showing the list of animations.
@property (strong, nonatomic) UIPopoverController *animationsSelectPopover;

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
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Create the means to select the animation.
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
	btn.frame = CGRectMake(0, 0, 100, 40);
	btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
	[btn setTitle:@"Translate" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[btn addTarget:self action:@selector(didTapTitle:) forControlEvents:UIControlEventTouchUpInside];
	
	// Add the item to the navigation bar.
	UINavigationItem *item = [[UINavigationItem alloc] init];
	item.titleView = btn;
	self.navigationBar.items = @[item];
	
	// Create the animation select table view.
	self.animationsList = [[MTZAnimationSelectTableViewController alloc] initWithStyle:UITableViewStylePlain];
	self.animationsList.delegate = self;
	
	// Create the popover.
	self.animationsSelectPopover = [[UIPopoverController alloc] initWithContentViewController:self.animationsList];
	self.animationsSelectPopover.popoverContentSize = CGSizeMake(280, 132);
	
	// Create parameters view controller.
	self.parametersVC = [[MTZSpringAnimationParametersViewController alloc] initWithNibName:@"MTZSpringAnimationParametersViewController" bundle:nil];
	// Add it to the appropriate container view.
	[self.parametersView addSubview:self.parametersVC.view];
	
	// The default animation.
	[self loadAnimationNamed:@"Translate"];
}

- (void)loadAnimationNamed:(NSString *)name
{
	// Create animations view controller.
	if ( [name isEqualToString:@"Translate"] ) {
		self.animationsVC = [[MTZSpringAnimationTranslateViewController alloc] initWithNibName:@"MTZSpringAnimationTranslateViewController" bundle:nil];
	} else if ( [name isEqualToString:@"Rotate"] ) {
		self.animationsVC = [[MTZSpringAnimationRotateViewController alloc] initWithNibName:@"MTZSpringAnimationRotateViewController" bundle:nil];
	} else {
		
	}
	
	// Remove all subviews of animations view
	for ( UIView *subview in [self.animationsView subviews] ) {
		[subview removeFromSuperview];
	}
	
	// Add it to the appropriate container view.
	[self.animationsView addSubview:self.animationsVC.view];
}

// When the animate/play button is tapped.
- (IBAction)animate:(id)sender
{
	// Tell the animations view controller to animate based on the parameters.
	[self.animationsVC animateWithDuration:self.parametersVC.duration
					usingSpringWithDamping:self.parametersVC.dampingRatio
					 initialSpringVelocity:self.parametersVC.velocity];
	
	[self resetProgress];
	[NSObject cancelPreviousPerformRequestsWithTarget:self
											 selector:@selector(resetProgress)
											   object:nil];
	
	// Animate the progress of the animation at the same rate.
	[UIView animateWithDuration:self.parametersVC.duration
						  delay:0.0f
						options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
					 animations:^{
						 [self.progressView setProgress:1.0f animated:YES];
					 }
					 completion:^(BOOL finished) {}];
	
	// Reset the progress view after the completion of the animation.
	[self performSelector:@selector(resetProgress)
			   withObject:nil
			   afterDelay:self.parametersVC.duration + TIME_TO_WAIT_AFTER_ANIMATION];
}

// The animation ended, reset the progress bar.
- (void)resetProgress
{
	[self.progressView setProgress:0.0f animated:NO];
}

// The title in the navigation bar was tapped.
- (void)didTapTitle:(id)sender
{
	[self.animationsSelectPopover presentPopoverFromRect:self.navigationBar.frame
												  inView:self.view
								permittedArrowDirections:UIPopoverArrowDirectionUp
												animated:YES];
}


#pragma mark - MTZAnimationSelectTableViewControllerDelgate

- (void)tableViewController:(MTZAnimationSelectTableViewController *)tableViewController
	didSelectAnimationNamed:(NSString *)name
{
	[self loadAnimationNamed:name];
	[self.animationsSelectPopover dismissPopoverAnimated:YES];
}


#pragma mark - UIViewController Misc.

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

@end
