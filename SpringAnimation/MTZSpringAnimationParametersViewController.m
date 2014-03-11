//
//  MTZSpringAnimationParametersViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZSpringAnimationParametersViewController.h"

@interface MTZSpringAnimationParametersViewController ()

/// The label for the example code.
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

/// The slider for the animation duration parameter.
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
/// The slider for the spring damping parameter.
@property (weak, nonatomic) IBOutlet UISlider *dampingSlider;
/// The slider for the inital velocity parameter.
@property (weak, nonatomic) IBOutlet UISlider *velocitySlider;

@end

@implementation MTZSpringAnimationParametersViewController

/// Perfomed when parameter slider values are changed.
- (IBAction)parameterSliderDidChange:(id)sender
{
	// The example code.
	NSString *string = [NSString stringWithFormat:@"    [UIView animateWithDuration:%.2f\n                          delay:0.0\n         usingSpringWithDamping:%.2f\n          initialSpringVelocity:%.2f\n                        options:0\n                      animations:...\n                     completion:...];", _durationSlider.value, _dampingSlider.value, _velocitySlider.value];
	
	// Create an attributed string to color in the parameters.
	NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
	
	
#warning What is the easiest way to not hard-code the location of each parameter?
	
	// Duration
	[attrString addAttribute:NSForegroundColorAttributeName
					   value:_durationSlider.tintColor
					   range:NSMakeRange(32, 4)];
	
	// Damping
	[attrString addAttribute:NSForegroundColorAttributeName
					   value:_dampingSlider.tintColor
					   range:NSMakeRange(105, 4)];
	
	// Initial Velocity
	[attrString addAttribute:NSForegroundColorAttributeName
					   value:_velocitySlider.tintColor
					   range:NSMakeRange(142, 4)];
	
	// Update the code label.
	_codeLabel.attributedText = attrString;
}


#pragma mark Public Properties

- (float)duration
{
	return _durationSlider.value;
}

- (float)dampingRatio
{
	return _dampingSlider.value;
}

- (float)velocity
{
	return _velocitySlider.value;
}

@end
