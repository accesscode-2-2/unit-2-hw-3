//
//  TaskCreateViewController.m
//  MarsWater
//
//  Created by Shena Yoshida on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreateViewController.h"
#import <CoreData/CoreData.h>
#import "Task.h"
#import "AppDelegate.h" // to access the cool built in core data methods
#import "List.h"

@interface TaskCreateViewController ()

@property (nonatomic) Task *task;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UISlider *prioritySlider;
@property (nonatomic) NSNumber *priorityNumber;

@end

@implementation TaskCreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (void)setupNavigationBar
{
    // set the title
    self.navigationItem.title = @"Create To Do Item";
    
    // set the left button to cancel
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    // set the right button to save
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    // NSLog(@"%@", self.taskTextField.text); // test it!
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sliderValueChanged:(id)sender
{
    self.priorityNumber = [[NSNumber alloc]initWithFloat:self.prioritySlider.value]; // set slider value to storage number
}

- (void)save
{
    if (self.taskTextField.text.length != 0) { // if there is text to save
        
        self.task.taskDescription = self.taskTextField.text;
        self.task.createdAt = [NSDate date];
        self.task.priority = self.priorityNumber;
        self.task.list = self.list;
        
        // self.task.dueAt =
        // self.task.completedAt =
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate; // set delegate
        
        [delegate.managedObjectContext save:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil]; // dismiss viewController and return to TaskTableView
    }
    
    NSLog(@"task: %@, created at: %@, priority: %@", self.task.taskDescription, self.task.createdAt, self.task.priority); // test it!
}

@end
