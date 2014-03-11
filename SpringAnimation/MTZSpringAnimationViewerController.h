//
//  MTZSpringAnimationViewerController.h
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTZSpringAnimationViewerController : UIViewController

/*
 Defines an abstract class for a view controller with demo spring animations.
 This class itself does not have any spring animation. You must subclass to use.
 */


#pragma mark - Public API

/// Begin the spring animation.
- (void)animateWithDuration:(NSTimeInterval)duration
	 usingSpringWithDamping:(float)dampingRatio
	  initialSpringVelocity:(float)velocity;


#pragma mark - Methods for Subclasses to Override.

/// The animation to demonstrate.
- (void)animate;

/// Reset the state of the animation to the beginning.
- (void)reset;

@end
