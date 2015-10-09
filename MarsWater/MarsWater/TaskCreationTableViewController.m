//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Justine Gartner on 10/5/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "TaskTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController () <TaskTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UIButton *highButton;
@property (weak, nonatomic) IBOutlet UIButton *lowButton;

@property (nonatomic) BOOL priorityButtonSelected;

@property (nonatomic) Task *task;
@property (nonatomic) Task *selectedTask;

@property (nonatomic) NSMutableOrderedSet *listTasks;

@end

@implementation TaskCreationTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.priorityButtonSelected = NO;
    
    self.listTasks = self.list.task.mutableCopy;
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
}

/*
-(void)viewWillAppear:(BOOL)animated{
    
    if (self.task == nil) {
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;

        self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    }else{
        
        
    }
}*/



-(void)setupNavigationBar{
    
    self.navigationItem.title = [NSString stringWithFormat:@"Add New Task to %@", self.list.title];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:224.0/255.0 green:35.0/255.0 blue:70.0/255.0 alpha:1.0];
}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save{
    
    if (self.priorityButtonSelected == NO) {
        
        [self alertController];
    
    }else {
        
        //set task properties
        
        [self setTaskProperties];
        
        
        //update List's Task (NSOrderedSet)
        
        self.list.task = self.listTasks;
        
        
        //save task with NSManagedObjectContext
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.managedObjectContext save:nil];
        
        
        //clear self.task
        
        self.task = nil;
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - taskTableViewControllerDelegate protocol methods

-(void)didSelectTask:(Task *)selectedTask atIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedTask = selectedTask;
    
    NSLog(@"selected task: %@", selectedTask);
}

#pragma mark - task properties

-(void)setTaskProperties{
    
    self.task.taskDescription = self.taskTextField.text;
    
    if (self.task.createdAt == nil) {
        
        self.task.createdAt = [NSDate date];
        
    }else {
        
        self.task.updatedAt = [NSDate date];
    }
}


#pragma mark - priority button

- (IBAction)priorityButtonTapped:(UIButton *)sender {
    
    self.priorityButtonSelected = YES;
    
    if (sender == self.highButton) {
        
        [self.listTasks insertObject:self.task atIndex:0];
    
    }else if (sender == self.lowButton){
        
        [self.listTasks insertObject:self.task atIndex:self.listTasks.count];
    }

}

#pragma mark - alertController

-(void)alertController{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                   message:@"Please select a priority level."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark - update list task
//Not currently in use, but was.
//Keeping for reference.

/*
 -(void)updateListOfTasks{
 
 self.listTasks = self.list.task.mutableCopy;
 
 [self.listTasks addObject:self.task];
 
 self.list.task = self.listTasks;
 
 }*/



@end
