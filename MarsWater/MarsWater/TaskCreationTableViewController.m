//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Xiulan Shi on 10/6/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//


#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"


@interface TaskCreationTableViewController ()

@property (nonatomic) NSMutableOrderedSet *listTasks;

@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueAtDatePicker;

@property (nonatomic) Task *task;

@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listTasks = self.list.task.mutableCopy;
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = [NSString stringWithFormat:@"Add New Task to %@", self.list.title];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    
    self.task.taskDescription = self.descriptionTextField.text;
    self.task.priority = [NSNumber numberWithInteger:[self.priorityTextField.text integerValue]];
    self.task.dueAt = self.dueAtDatePicker.date;
    self.task.createAt = [NSDate date];
    self.task.list = self.list;
    
    [self.listTasks addObject:self.task];

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
