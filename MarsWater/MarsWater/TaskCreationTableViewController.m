//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Charles Kang on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *createTaskTextField;

@property (nonatomic) NSMutableOrderedSet *listTasks;
@property (nonatomic) NSIndexPath *selectedTaskIndexPath;

@property (nonatomic) Task *task;
@property (nonatomic) Task *selectedTask;

@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Create Tasks";
    
    self.createTaskTextField.text = @"";
    
    self.listTasks = self.list.task.mutableCopy;
    
    [self setupNavigationBar];
    [self createNewTask];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
}

-(void)createNewTask{
    
    if (self.selectedTask == nil) {
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
        NSLog(@"new task, %@ saved", self.listTasks);
    }
}

-(void)setupNavigationBar{
    
    if (self.selectedTask == nil) {
        
        self.navigationItem.title = [NSString stringWithFormat:@"Add New Task to %@", self.list.title];
        
    }else {
        
        self.navigationItem.title = [NSString stringWithFormat:@"Edit %@", self.selectedTask.taskDescription];
        
        self.createTaskTextField.placeholder = self.selectedTask.taskDescription;
        
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    
}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save{
    
    [self setNewTaskProperties];
    [self setSelectedTaskProperties];
    
    // set the task properties
    
    self.task.taskDescription = self.createTaskTextField.text;
    
    if (self.task.createdAt == nil) {
        
        self.task.createdAt = [NSDate date];
        NSLog(@"%@", self.task);
        
    } else {
        
        self.task.updatedAt = [NSDate date];
    }
    
    //    self.list.task = self.listTasks;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.managedObjectContext save:nil];
    
    self.task = nil;
    self.selectedTask = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)didSelectTask:(Task *)selectedTask atIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedTask = selectedTask;
    
    self.selectedTaskIndexPath = indexPath;
    
    NSLog(@"selected task: %@", selectedTask);
}

-(void)setNewTaskProperties{
    
    if (self.task != nil){
        
        self.task.taskDescription = self.createTaskTextField.text;
        
        self.task.createdAt = [NSDate date];
    }
}

-(void)setSelectedTaskProperties{
    
    if (self.selectedTask != nil) {
        
        self.selectedTask.taskDescription = self.createTaskTextField.text;
        
        self.selectedTask.updatedAt = [NSDate date];
    }
}

@end
