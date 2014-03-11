//
//  MTZSpringAnimationParametersViewController.h
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTZSpringAnimationParametersViewController : UIViewController

/// The desired duration of the spring animation.
@property (readonly) float duration;

/// The desired damping ratio of the spring animation.
@property (readonly) float dampingRatio;

/// The desired initial velocity of the spring animation.
@property (readonly) float velocity;

@end
