//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Lauren Caponong on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"


// TASK PROPERTIES

    //@property (nullable, nonatomic, retain) NSString *taskDescription;
    //@property (nullable, nonatomic, retain) NSDate *createdAt;
    //@property (nullable, nonatomic, retain) NSDate *dueAt;
    //@property (nullable, nonatomic, retain) NSDate *updatedAt;
    //@property (nullable, nonatomic, retain) NSNumber *priority;
    //@property (nullable, nonatomic, retain) NSDate *completedAt;
    //@property (nullable, nonatomic, retain) id color;
    //@property (nullable, nonatomic, retain) List *list;




@interface TaskCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) Task *task;

@end



@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Create New Task";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    // set the right button to save
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    self.task.taskDescription = self.titleTextField.text;
    self.task.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction)colorButtonTapped:(UIButton *)sender {
//    
//    self.task.color = sender.backgroundColor;
//    
//}

    
@end

