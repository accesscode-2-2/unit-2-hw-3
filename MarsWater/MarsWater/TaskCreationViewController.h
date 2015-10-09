//
//  TaskCreationViewController.h
//  MarsWater
//
//  Created by Bereket  on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TasksTableViewController.h"
#import <CoreData/CoreData.h>
#import "Task.h"

@interface TaskCreationViewController : UIViewController

<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *addTaskTextField;
@property (nonatomic) Task* task;
@end
