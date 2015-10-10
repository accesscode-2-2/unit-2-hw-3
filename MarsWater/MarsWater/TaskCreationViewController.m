//
//  TaskCreationViewController.m
//  MarsWater
//
//  Created by Natalia Estrella on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TaskCreationViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface TaskCreationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation TaskCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)createTapped:(id)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];

    task.taskDescription = self.descriptionField.text;
    task.createdAt = [NSDate date];
    task.updatedAt = [NSDate date];
    task.dueAt = self.datePicker.date;
    task.priority = @(1);
    
    [delegate.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
