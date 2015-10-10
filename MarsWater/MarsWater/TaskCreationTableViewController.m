//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Diana Elezaj on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) Task *task;
@property (nonatomic) NSMutableOrderedSet *set;
@property (weak, nonatomic) IBOutlet UIButton *priority1;
@property (weak, nonatomic) IBOutlet UIButton *priority2;
@property (weak, nonatomic) IBOutlet UIButton *priority3;
@property (weak, nonatomic) IBOutlet UIButton *priority4;
@property (weak, nonatomic) IBOutlet UIButton *priority5;
@property (nonatomic) NSNumber *priorityNumber;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic) UIImage *whiteStarBackground;
@property (nonatomic) UIImage *yellowStarBackground;






@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.whiteStarBackground = [UIImage imageNamed:@"WhiteStar"];
    self.yellowStarBackground = [UIImage imageNamed:@"YellowStar"];
    
    self.priorityNumber = @1;
    [self.priority1 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    
    [self.datePicker setMinimumDate: [NSDate date]];
    
    self.set = [self.list.task mutableCopy];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Add task to %@", self.list.title];
    
}

- (IBAction)cancelTask:(UIBarButtonItem *)sender {
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    [delegate.managedObjectContext deleteObject:self.list];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveTask:(UIBarButtonItem *)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if ([self.textField.text isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooops!" message:@"Please fill out the title field" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK action");
                                   }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
    
    
    
    
    self.task.taskDescription = self.textField.text;
    self.task.createdAt = [NSDate date];
    self.task.priority = self.priorityNumber;
    self.task.dueAt = self.datePicker.date;
  
        
    [self.set addObject:self.task];
    
    self.list.task = self.set;
    
    [delegate.managedObjectContext save:nil];
//        NSLog(@"**** list%@", self.list);
        NSLog(@"**** self.task.priority   %@", self.task.priority);
        NSLog(@"**** due   %@", self.task.dueAt);

    
    [self dismissViewControllerAnimated:YES completion:nil];
}
}



- (IBAction)priority1Selected:(UIButton *)sender {
    self.priorityNumber = @1;
    [self.priority1 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority2 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
    [self.priority3 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
    [self.priority4 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
    [self.priority5 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
    
    
}
- (IBAction)priority2Selected:(UIButton *)sender {
    self.priorityNumber = @2;
    [self.priority1 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority2 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority3 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
    [self.priority4 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
    [self.priority5 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
}
- (IBAction)priority3Selected:(UIButton *)sender {
    self.priorityNumber = @3;
    [self.priority1 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority2 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority3 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority4 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
    [self.priority5 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
}
- (IBAction)priority4Selected:(UIButton *)sender {
    self.priorityNumber = @4;
    [self.priority1 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority2 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority3 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority4 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority5 setBackgroundImage:self.whiteStarBackground forState:UIControlStateNormal];
}
- (IBAction)priority5Selected:(UIButton *)sender {
    self.priorityNumber = @5;
    [self.priority1 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority2 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority3 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority4 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
    [self.priority5 setBackgroundImage:self.yellowStarBackground forState:UIControlStateNormal];
}
















@end
