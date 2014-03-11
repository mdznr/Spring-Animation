//
//  MTZViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <CoreText/CoreText.h>

#import "MTZViewController.h"

@interface MTZViewController ()

// The parameter sliders.
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UISlider *dampingSlider;
@property (weak, nonatomic) IBOutlet UISlider *velocitySlider;

// The example animation code.
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

// The view to animate.
@property (weak, nonatomic) IBOutlet UIView *testView;

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
	
	// Force value label update for all parameters.
	[self parameterSliderChanged:nil];
}

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

/// Perfomed when parameter slider values are changed.
- (IBAction)parameterSliderChanged:(UISlider *)sender
{
	NSString *string = [NSString stringWithFormat:@"[UIView animateWithDuration:%.2f\n                      delay:0.0\n     usingSpringWithDamping:%.2f\n      initialSpringVelocity:%.2f\n                    options:0\n                 animations:...\n                 completion:...];", _durationSlider.value, _dampingSlider.value, _velocitySlider.value];
	NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
	
#warning Easiest way of not hard-coding in the location of each value?
	// Duration
	[attrString addAttribute:NSForegroundColorAttributeName value:_durationSlider.tintColor range:NSMakeRange(28, 4)];
	// Damping
	[attrString addAttribute:NSForegroundColorAttributeName value:_dampingSlider.tintColor range:NSMakeRange(93, 4)];
	// Initial Velocity
	[attrString addAttribute:NSForegroundColorAttributeName value:_velocitySlider.tintColor range:NSMakeRange(126, 4)];
	
	_codeLabel.attributedText = attrString;
}

- (void)resetAnimatedViews
{
	// Put the test view back where it belongs.
	_testView.transform = CGAffineTransformIdentity;
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
