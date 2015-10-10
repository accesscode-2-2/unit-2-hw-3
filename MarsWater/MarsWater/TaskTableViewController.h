//
//  TaskTableViewController.h
//  MarsWater
//
//  Created by Christian Maldonado on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@interface TaskTableViewController : UITableViewController

@property (nonatomic) List *list;
@property (nonatomic) NSIndexPath *indexPath;

@end
