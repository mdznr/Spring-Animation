//
//  MTZAnimationSelectTableViewController.h
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTZAnimationSelectTableViewController;

@protocol MTZAnimationSelectTableViewControllerDelgate <NSObject>

/// An animation was selected.
/// @param tableViewController The table view controller sending this message.
/// @param name The name of the animation that was selected.
- (void)tableViewController:(MTZAnimationSelectTableViewController *)tableViewController
	didSelectAnimationNamed:(NSString *)name;

@end


@interface MTZAnimationSelectTableViewController : UITableViewController

/// The animation select table view controller's delegate
@property (nonatomic) id<MTZAnimationSelectTableViewControllerDelgate> delegate;

/// The names of all the animations shown.
@property (strong, nonatomic) NSArray *animationNames;

/// The name of the selected animation in the table view.
@property (strong, nonatomic) NSString *currentAnimationName;

@end
