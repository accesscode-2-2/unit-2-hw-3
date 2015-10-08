//
//  TasksTableViewController.h
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/5/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TasksTableViewController : UITableViewController

@property (nonatomic) List *listAtIndexPath;
@property (nonatomic) NSIndexPath *indexPath;

@end
