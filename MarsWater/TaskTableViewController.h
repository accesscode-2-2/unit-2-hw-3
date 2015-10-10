//
//  TaskTableViewController.h
//  MarsWater
//
//  Created by Zoufishan Mehdi on 10/8/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "List.h"


@interface TaskTableViewController : UITableViewController

@property (nonatomic) Task *task;
@property (nonatomic) List *list;

@end
