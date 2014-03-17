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
#import "MTZSpringAnimationExpandViewController.h"
#import "MTZAnimationSelectTableViewController.h"

@interface MTZViewController () <MTZAnimationSelectTableViewControllerDelgate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

/// The control to interact with in the title view of the navigation bar.
@property (strong, nonatomic) UIButton *titleButton;

/// The animation names and corresponding classes.
@property (strong, nonatomic) NSDictionary *animations;

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
	
	// All the possible animations.
	_animations = @{
					@"Translate": [MTZSpringAnimationTranslateViewController class],
					@"Rotate": [MTZSpringAnimationRotateViewController class],
					@"Expand": [MTZSpringAnimationExpandViewController class]
					};
	
	// Create the means to select the animation.
	_titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
	_titleButton.frame = CGRectMake(0, 0, 100, 40);
	_titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
	[_titleButton setTitleColor:[UIApplication sharedApplication].keyWindow.tintColor
					   forState:UIControlStateNormal];
	UIImage *image = [UIImage imageNamed:@"DownArrow"];
	[_titleButton setImage:image forState:UIControlStateNormal];
	[_titleButton addTarget:self action:@selector(didTapTitle:) forControlEvents:UIControlEventTouchUpInside];
	
	// Add the item to the navigation bar.
	UINavigationItem *item = [[UINavigationItem alloc] init];
	item.titleView = _titleButton;
	self.navigationBar.items = @[item];
	
	// Create the animation select table view.
	self.animationsList = [[MTZAnimationSelectTableViewController alloc] initWithStyle:UITableViewStylePlain];
	self.animationsList.delegate = self;
	self.animationsList.animationNames = [self.animations allKeys];
	
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
	// Find the animation.
	BOOL foundAnimation = NO;
	for ( NSString *animationName in [self.animations allKeys] ) {
		if ( [animationName isEqualToString:name] ) {
			// Create the animations view controller.
			Class animationVC = [self.animations valueForKey:animationName];
			NSString *nibName = NSStringFromClass(animationVC);
			self.animationsVC = [[animationVC alloc] initWithNibName:nibName bundle:nil];;
			foundAnimation = YES;
			break;
		}
	}
	
	if ( !foundAnimation ) {
		NSLog(@"Error: No animation named \"%@\"", name);
		return;
	}
	
	// Update the title (in the navigation bar).
	self.title = name;
	
	// Remove all subviews of animations view
	for ( UIView *subview in [self.animationsView subviews] ) {
		[subview removeFromSuperview];
	}
	
	// Add it to the appropriate container view.
	[self.animationsView addSubview:self.animationsVC.view];
}

- (void)setTitle:(NSString *)title
{
	[super setTitle:title];
	[_titleButton setTitle:title forState:UIControlStateNormal];
	
	UIImage *image = [_titleButton imageForState:UIControlStateNormal];
	
	_titleButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, _titleButton.frame.size.width - image.size.width, 0.0f, 0.0f);
	_titleButton.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, image.size.width);
}

// When the animate/play button is tapped.
- (IBAction)animate:(id)sender
{
	// Tell the animations view controller to animate based on the parameters.
	[self.animationsVC animateWithDuration:self.parametersVC.duration
					usingSpringWithDamping:self.parametersVC.dampingRatio
					 initialSpringVelocity:self.parametersVC.velocity];
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self
											 selector:@selector(resetProgress)
											   object:nil];
	[self resetProgress];
	
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
	NSString *currentAnimationName = [self.titleButton titleForState:UIControlStateNormal];
	MTZAnimationSelectTableViewController *vc = (MTZAnimationSelectTableViewController *) self.animationsSelectPopover.contentViewController;
	vc.currentAnimationName = currentAnimationName;
	
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
