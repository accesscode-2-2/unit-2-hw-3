//
//  TaskCreationTableViewController.h
//  MarsWater
//
//  Created by Felicia Weathers on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "List.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController : UITableViewController

@property (nonatomic) List *lists;
@property (nonatomic) Task *task;

@end
