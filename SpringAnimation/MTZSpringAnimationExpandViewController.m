//
//  MTZSpringAnimationExpandViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZSpringAnimationExpandViewController.h"

@interface MTZSpringAnimationExpandViewController ()

@property (weak, nonatomic) IBOutlet UIView *blockView;

@end

@implementation MTZSpringAnimationExpandViewController

- (void)animate
{
	// Scale the block up.
	_blockView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.618, 1.618);
}

- (void)reset
{
	// Put the test view back where it belongs.
	_blockView.transform = CGAffineTransformIdentity;
}

@end
