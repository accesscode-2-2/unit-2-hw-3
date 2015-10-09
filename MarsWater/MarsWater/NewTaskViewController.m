//
//  NewTaskViewController.m
//  MarsWater
//
//  Created by Henna on 10/9/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "NewTaskViewController.h"
#import <CoreData/CoreData.h>
#import "Task.h"
#import "AppDelegate.h" 
#import "List.h"

@interface NewTaskViewController ()
@property (nonatomic) Task *task;
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (void)setupNavigationBar
{
    self.navigationItem.title = @"Create To Do Item";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)save
{
    if (self.taskName.text.length != 0) {
        
        self.task.taskDescription = self.taskName.text;
        self.task.createdAt = [NSDate date];
        self.task.list = self.list;
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.managedObjectContext save:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"💁" message:@"Please enter a task name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    
    }
    
}

@end
