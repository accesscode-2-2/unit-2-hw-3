//
//  TasksTableViewController.h
//  MarsWater
//
//  Created by Henna on 10/9/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "ListTableViewController.h"
#import "AppDelegate.h"
#import "List.h"

@interface TasksTableViewController : UITableViewController
@property (nonatomic) Task *task;
@property (nonatomic) List *list;

@end
