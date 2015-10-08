//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Justine Gartner on 10/5/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TaskCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UIButton *highButton;
@property (weak, nonatomic) IBOutlet UIButton *lowButton;

@property (nonatomic) Task *task;

@property (nonatomic) NSMutableOrderedSet *listTasks;

@end

@implementation TaskCreationTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.listTasks = self.list.task.mutableCopy;
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
}

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
    
    //set task properties
    
    self.task.taskDescription = self.taskTextField.text;
    
    if (self.task.createdAt == nil) {
        
        self.task.createdAt = [NSDate date];
        
    }else {
        
        self.task.updatedAt = [NSDate date];
    }
    
    
    //update List's Task (NSOrderedSet)
    
    self.list.task = self.listTasks;
    
    
    //save to task to core data context
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - update list task
//not currently in use, but was
//keeping for reference

/*
-(void)updateListOfTasks{
    
    self.listTasks = self.list.task.mutableCopy;
    
    [self.listTasks addObject:self.task];
    
    self.list.task = self.listTasks;
    
}*/

#pragma mark - priority button

- (IBAction)priorityButtonTapped:(UIButton *)sender {
    
    if (sender == self.highButton) {
        
        [self.listTasks insertObject:self.task atIndex:0];
    
    }else if (sender == self.lowButton){
        
        [self.listTasks insertObject:self.task atIndex:self.listTasks.count];
    }

}

@end
