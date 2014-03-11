//
//  MTZSpringAnimationViewerController.h
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TIME_TO_WAIT_AFTER_ANIMATION 1

@interface MTZSpringAnimationViewerController : UIViewController

/*
 Defines an abstract class for a view controller with demo spring animations.
 This class itself does not have any spring animation. You must subclass to use.
 */


#pragma mark - Public API

/// Begin the spring animation.
/// @discussion This method is not meant to be overriden.
- (void)animateWithDuration:(NSTimeInterval)duration
	 usingSpringWithDamping:(float)dampingRatio
	  initialSpringVelocity:(float)velocity;


#pragma mark - Methods for Subclasses to Override.

/// The animation to demonstrate.
/// @discussion Do not call this method directly.
/// @discussion Subclasses must override this method. Do not call this method on @c super.
- (void)animate;

/// Reset the state of the animation to the beginning.
/// @discussion Do not call this method directly.
/// @discussion Subclasses must override this method. Do not call this method on @c super.
- (void)reset;

@end
