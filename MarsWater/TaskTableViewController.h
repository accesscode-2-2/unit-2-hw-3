//
//  TaskTableViewController.h
//  MarsWater
//
//  Created by Shena Yoshida on 10/6/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "ListsTableViewController.h"
#import "AppDelegate.h"

@interface TaskTableViewController : UITableViewController

@property (nonatomic) Task *task;
@property (nonatomic) NSString *listName;
@property (nonatomic) id listColor;

@end
