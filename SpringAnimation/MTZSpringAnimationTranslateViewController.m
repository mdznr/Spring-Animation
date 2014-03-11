//
//  MTZSpringAnimationTranslateViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZSpringAnimationTranslateViewController.h"

@interface MTZSpringAnimationTranslateViewController ()

@property (weak, nonatomic) IBOutlet UIView *blockView;

@end

@implementation MTZSpringAnimationTranslateViewController

- (void)animate
{
	// Translate the block over 320 points.
	_blockView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 320, 0);
}

- (void)reset
{
	// Put the test view back where it belongs.
	_blockView.transform = CGAffineTransformIdentity;
}

@end
