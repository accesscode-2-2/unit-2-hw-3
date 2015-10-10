//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Umar on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) Task *task;
@property (nonatomic) NSMutableOrderedSet *orderedSet;
@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderedSet = [self.list.task mutableCopy];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
    }

- (IBAction)saveTask:(UIBarButtonItem *)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task.taskDescription = self.textField.text;
    self.task.createdAt = [NSDate date];
    [self.orderedSet addObject:self.task];
    self.list.task = self.orderedSet;
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
