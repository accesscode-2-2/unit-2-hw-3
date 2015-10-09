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

@interface TaskCreationTableViewController () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *doAtDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *taskDescriptionTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegementedController;
@property (nonatomic) Task *task;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Create a task";
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButtonTapped:(id)sender {
    self.task.createdAt = [NSDate date];
    self.task.doAt = self.doAtDatePicker.date;
    self.task.taskDescription = self.taskDescriptionTextField.text;
    self.task.priority = [NSNumber numberWithInteger: self.prioritySegementedController.selectedSegmentIndex];
    self.task.list = self.list;
    NSMutableOrderedSet *mutableSet = self.list.task.mutableCopy;
    [mutableSet addObject:self.task];
    self.list.task = [[NSOrderedSet alloc] initWithOrderedSet:mutableSet];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
