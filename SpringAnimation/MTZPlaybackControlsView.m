//
//  MTZPlaybackControlsView.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZPlaybackControlsView.h"

@interface MTZPlaybackControlsView ()

@property (strong, nonatomic) UIButton *playPauseButton;

@end

@implementation MTZPlaybackControlsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self __MTZPlaybackControlsView__setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		// Initialization code
		[self __MTZPlaybackControlsView__setup];
	}
	return self;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		// Initialization code
		[self __MTZPlaybackControlsView__setup];
	}
	return self;
}

- (void)__MTZPlaybackControlsView__setup
{
	// Light gray background.
	self.backgroundColor = [UIColor lightGrayColor];
	
	// Play/Pause button on the left.
	_playPauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.frame.size.height)];
	_playPauseButton.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	[_playPauseButton setImage:nil forState:UIControlStateNormal];
	
	[self addSubview:_playPauseButton];
}

@end
