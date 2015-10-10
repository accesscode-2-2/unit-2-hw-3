//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Charles Kang on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *createTaskTextField;
@property (nonatomic) NSMutableOrderedSet *listTasks;
@property (nonatomic) Task *task;

@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Create Tasks";
    
    self.listTasks = [self.list.task mutableCopy];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (IBAction)saveTask:(id)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task.taskDescription = self.createTaskTextField.text;
    self.task.createdAt = [NSDate date];
    
    [self.listTasks addObject:self.task];
    
    self.list.task = self.listTasks;
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"please work");

}

- (IBAction)cancelTask:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
