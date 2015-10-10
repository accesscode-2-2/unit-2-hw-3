//
//  TaskCreationViewController.m
//  MarsWater
//
//  Created by Eric Sze on 10/9/15.
//  Copyright © 2015 myApps. All rights reserved.
//

#import "TaskCreationViewController.h"



@interface TaskCreationViewController ()

@property (nonatomic) Task *task;
@property (nonatomic, weak) IBOutlet UITextField *taskTextField;
@property (nonatomic) NSMutableOrderedSet *listTasks;

@end

@implementation TaskCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (void)setupNavigationBar {
    // set the title
    // set the left bar to cancel
    // set the right button to add task
    
    self.navigationItem.title = @"Create New Task";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if (self.taskTextField.text.length != 0) {
        self.task.taskDescription = self.taskTextField.text;
        self.task.createdAt = [NSDate date];
        self.task.list = self.list;
        
        [delegate.managedObjectContext save:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    NSLog(@"%@", self.task.taskDescription);
}





@end