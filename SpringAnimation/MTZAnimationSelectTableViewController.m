//
//  MTZAnimationSelectTableViewController.m
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZAnimationSelectTableViewController.h"

@interface MTZAnimationSelectTableViewController ()

@end


@implementation MTZAnimationSelectTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)setCurrentAnimationName:(NSString *)currentAnimationName
{
	for ( NSUInteger i=0; i<self.animationNames.count; ++i ) {
		NSString *animationName = self.animationNames[i];
		NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
		if ( [animationName isEqualToString:currentAnimationName] ) {
			_currentAnimationName = currentAnimationName;
			
			// Add a checkmark.
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			// Remove any checkmark.
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return self.animationNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	
    // Configure the cell...
	cell.textLabel.text = self.animationNames[indexPath.row];
 
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// The title of the animation that was selected.
	NSString *title = self.animationNames[indexPath.row];
	
	// Tell the delegate that the animation was selected.
	[self.delegate tableViewController:self didSelectAnimationNamed:title];
}

@end
