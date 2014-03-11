//
//  MTZSpringAnimationViewerController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZSpringAnimationViewerController.h"

#import "AbstractClass.h"

@interface MTZSpringAnimationViewerController ()

@end

@implementation MTZSpringAnimationViewerController

- (void)animateWithDuration:(NSTimeInterval)duration
	 usingSpringWithDamping:(float)dampingRatio
	  initialSpringVelocity:(float)velocity
{
	// Ensure animation won't be interrupted by a pending reset (completion of a prior animation).
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reset) object:nil];
	
	// Reset the animation.
	[self reset];
	
	// Perform the spring animation.
	[UIView animateWithDuration:duration
						  delay:0.0f
		 usingSpringWithDamping:dampingRatio
		  initialSpringVelocity:velocity
						options:0
					 animations:^{
						 // Perform the subclass's animation.
						 [self animate];
					 }
					 completion:^(BOOL finished) {
						 // Reset shortly after the expected completion of the animation.
						 [self performSelector:@selector(reset)
									withObject:nil
									afterDelay:TIME_TO_WAIT_AFTER_ANIMATION];
					 }];
}

- (void)animate
{
	// Empty implementation.
	// Subclasses must override this method.
	MTZ_METHOD_MUST_BE_OVERRIDDEN
}

- (void)reset
{
	// Empty implementation.
	// Subclasses must override this method.
	MTZ_METHOD_MUST_BE_OVERRIDDEN
}

@end
