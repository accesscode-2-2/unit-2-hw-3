//
//  TasksTableViewController.h
//  MarsWater
//
//  Created by Charles Kang on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@protocol TaskTableViewControllerDelegate <NSObject>

@end

@interface TasksTableViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic) List *list;

//@interface TasksTableViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, weak)id <TaskTableViewControllerDelegate> delegate;

@property (nonatomic) NSIndexPath *selectedTaskIndexPath;

@end

