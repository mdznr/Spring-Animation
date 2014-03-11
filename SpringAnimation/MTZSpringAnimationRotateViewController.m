//
//  MTZSpringAnimationRotateViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZSpringAnimationRotateViewController.h"

@interface MTZSpringAnimationRotateViewController ()

@property (weak, nonatomic) IBOutlet UIView *blockView;

@end

@implementation MTZSpringAnimationRotateViewController

- (void)animate
{
	// Translate the block over 320 points.
	_blockView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
}

- (void)reset
{
	// Put the test view back where it belongs.
	_blockView.transform = CGAffineTransformIdentity;
}

@end
