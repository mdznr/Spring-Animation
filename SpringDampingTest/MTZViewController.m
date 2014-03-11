//
//  MTZViewController.m
//  SpringDampingTest
//
//  Created by Matt Zanchelli on 3/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZViewController.h"

@interface MTZViewController ()

// Sliders.
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UISlider *dampingSlider;
@property (weak, nonatomic) IBOutlet UISlider *velocitySlider;

// Values.
@property (weak, nonatomic) IBOutlet UILabel *durationValue;
@property (weak, nonatomic) IBOutlet UILabel *dampingValue;
@property (weak, nonatomic) IBOutlet UILabel *velocityValue;

// View to animate.
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Force value label update for all parameters.
	[self parameterSliderChanged:_durationSlider];
	[self parameterSliderChanged:_dampingSlider];
	[self parameterSliderChanged:_velocitySlider];
}

/// Perfomed with "Test Spring Animation" button is tapped.
- (IBAction)testSpringAnimation:(id)sender
{
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
	// Find which label to update.
	UILabel *label;
	if ( sender == _durationSlider ) {
		label = _durationValue;
	} else if ( sender == _dampingSlider ) {
		label = _dampingValue;
	} else if ( sender == _velocitySlider ) {
		label = _velocityValue;
	}
	
	// Put the value into a string and update it.
	NSString *value = [NSString stringWithFormat:@"%.2f", sender.value];
	label.text = value;
}


- (void)resetAnimatedViews
{
	// Put the test view back where it belongs.
	_testView.transform = CGAffineTransformIdentity;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
