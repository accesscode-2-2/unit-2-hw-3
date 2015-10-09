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
@property (nonatomic) NSIndexPath *selectedTaskIndexPath;

@property (nonatomic) NSMutableOrderedSet *listTasks;

@end

@implementation TaskCreationTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.priorityButtonSelected = NO;
    
    self.taskTextField.text = @"";
    
    self.listTasks = self.list.task.mutableCopy;
    
    [self setupNavigationBar];
    
    [self createNewTask];
    
}

-(void)createNewTask{
    
    if (self.selectedTask == nil) {
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    }

}

-(void)setupNavigationBar{
    
    if (self.selectedTask == nil) {
        
        self.navigationItem.title = [NSString stringWithFormat:@"Add New Task to %@", self.list.title];
    
    }else {
        
        self.navigationItem.title = [NSString stringWithFormat:@"Edit %@", self.selectedTask.taskDescription];
        
        self.taskTextField.placeholder = self.selectedTask.taskDescription;
        
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:224.0/255.0 green:35.0/255.0 blue:70.0/255.0 alpha:1.0];
}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save{
    
    if ([self.taskTextField.text isEqualToString:@""]) {
        
        [self emptyTextFieldAlertController];
    
    }else if (self.priorityButtonSelected == NO) {
        
        [self priorityAlertController];
    
    }else {
        
        //set task properties
        
        [self setNewTaskProperties];
        [self setSelectedTaskProperties];
        
        
        //update List's Task (NSOrderedSet)
        
        self.list.task = self.listTasks;
        
        
        //save task with NSManagedObjectContext
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.managedObjectContext save:nil];
        
        
        //clear self.task & self.selectedTask
        
        self.task = nil;
        self.selectedTask = nil;
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}



#pragma mark - taskTableViewControllerDelegate protocol methods

-(void)didSelectTask:(Task *)selectedTask atIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedTask = selectedTask;
    
    self.selectedTaskIndexPath = indexPath;
    
    NSLog(@"selected task: %@", selectedTask);
}

#pragma mark - task properties

-(void)setNewTaskProperties{
    
    if (self.task != nil){
        
        self.task.taskDescription = self.taskTextField.text;
        
        self.task.createdAt = [NSDate date];
    }
}

-(void)setSelectedTaskProperties{
    
    if (self.selectedTask != nil) {
        
        self.selectedTask.taskDescription = self.taskTextField.text;
        
        self.selectedTask.updatedAt = [NSDate date];
    }
}


#pragma mark - priority button

- (IBAction)priorityButtonTapped:(UIButton *)sender forTask: (Task *)task{
    
    self.priorityButtonSelected = YES;
    
    if (self.selectedTask == nil) {
        
        task = self.task;
        
        if (sender == self.highButton) {
            
            [self.listTasks insertObject:task atIndex:0];
            
        }else if (sender == self.lowButton){
            
            [self.listTasks insertObject:task atIndex:self.listTasks.count];
        }
        
    }else {
        
        task = self.selectedTask;
        
        
        NSMutableIndexSet *movedObjectIndex = [[NSMutableIndexSet alloc] init];
        
        [movedObjectIndex addIndex:self.selectedTaskIndexPath.row];
        
        
        if (sender == self.highButton) {
            
            [self.listTasks moveObjectsAtIndexes:movedObjectIndex toIndex:0];
            
        }else if (sender == self.lowButton){
            
            [self.listTasks moveObjectsAtIndexes:movedObjectIndex toIndex:self.listTasks.count];
        }
    }
    
    

}


#pragma mark - alertController

-(void)priorityAlertController{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                   message:@"Please select a priority level."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)emptyTextFieldAlertController{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                   message:@"Please fill in the task description."
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
