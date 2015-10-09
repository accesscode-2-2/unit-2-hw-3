//
//  TasksTableViewController.h
//  MarsWater
//
//  Created by Umar on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"
#import "Task.h"

@interface TasksTableViewController : UITableViewController

@property (nonatomic) List *list;
@property (nonatomic) List *nextIndexPath;
@property (nonatomic) NSIndexPath *indexPath;


@end
