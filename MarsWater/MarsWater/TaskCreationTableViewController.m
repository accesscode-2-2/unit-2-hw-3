//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Jovanny Espinal on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) Task *task;
@property (nonatomic) NSMutableOrderedSet *tempSet;
@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tempSet = [self.list.task mutableCopy];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];

    
}

- (IBAction)cancelTask:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveTask:(UIBarButtonItem *)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task.taskDescription = self.textField.text;
    self.task.createdAt = [NSDate date];
    
    [self.tempSet addObject:self.task];
    
    self.list.task = self.tempSet;
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
