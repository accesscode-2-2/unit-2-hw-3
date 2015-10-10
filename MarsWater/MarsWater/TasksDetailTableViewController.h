//
//  TasksDetailTableViewController.h
//  MarsWater
//
//  Created by Eric Sze on 10/7/15.
//  Copyright © 2015 myApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"
#import "AppDelegate.h"
#import "Task.h"
#import "ListsTableViewController.h"
#import "TaskCreationViewController.h"

@interface TasksDetailTableViewController : UITableViewController

@property (nonatomic) List *list;
@property (nonatomic) Task *task;

@end
