//
//  TasksTableViewController.h
//  MarsWater
//
//  Created by Diana Elezaj on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TasksTableViewController : UITableViewController
@property (nonatomic) NSMutableArray<Task *> *tasks;
@end
