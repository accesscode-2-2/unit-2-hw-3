//
//  TaskCreateTableViewController.m
//  MarsWater
//
//  Created by Brian Blanco on 10/9/15.
//  Copyright © 2015 Brian Blanco. All rights reserved.
//

#import "TaskCreateTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreateTableViewController () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) NSMutableArray*listOfTasks;
@property (nonatomic) Task *task;

@end

@implementation TaskCreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listOfTasks = [self.list.task mutableCopy];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task.taskDescription = self.textField.text;
    self.task.createdAt = [NSDate date];
    
    [self.listOfTasks addObject:self.task];
    
    self.list.task = self.listOfTasks;
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
