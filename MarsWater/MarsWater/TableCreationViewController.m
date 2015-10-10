//
//  TableCreationViewController.m
//  MarsWater
//
//  Created by Christian Maldonado on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TableCreationViewController.h"
#import "TaskTableViewController.h"
#import <CoreData/CoreData.h>
#import "ListsTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import "List.h"
@interface TableCreationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@property (nonatomic) Task *task;


@end

@implementation TableCreationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Create new task";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    self.task.taskDescription = self.taskTextField.text;
    self.task.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self.delegate didCreateTask:self.task];
    
    [self.navigationController popViewControllerAnimated:YES] ;
    
    
    
   // [self.tableview shouldReloadData];
}



@end
