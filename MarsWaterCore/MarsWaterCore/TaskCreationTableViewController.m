//
//  TaskCreationTableViewController.m
//  MarsWaterCore
//
//  Created by Daniel Distant on 10/6/15.
//  Copyright © 2015 ddistant. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import <CoreData/CoreData.h>

@interface TaskCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *doAtDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *taskDescriptionTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegementedController;
@property (nonatomic) Task *task;


@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Create a task";
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonTapped:(id)sender {
    self.task.createdAt = [NSDate date];
    self.task.doAt = self.doAtDatePicker.date;
    self.task.taskDescription = self.taskDescriptionTextField.text;
    self.task.priority = [NSNumber numberWithInteger: self.prioritySegementedController.selectedSegmentIndex];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
