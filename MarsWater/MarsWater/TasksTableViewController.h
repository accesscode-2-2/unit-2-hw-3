//
//  TasksTableViewController.h
//  MarsWater
//
//  Created by Jamaal Sedayao on 10/5/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "AppDelegate.h"
#import "ListTableViewController.h"

@interface TasksTableViewController : UITableViewController

@property (nonatomic) Task *task;
@property (nonatomic) NSString *listName;
@property (nonatomic) id listColor;


@end
