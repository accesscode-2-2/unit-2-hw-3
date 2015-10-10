//
//  TaskCreationViewController.m
//  MarsWater
//
//  Created by Zoufishan Mehdi on 10/8/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

#import "TaskCreationViewController.h"
#import "Task.h"
#import "AppDelegate.h"


@interface TaskCreationViewController ()

@property (nonatomic) Task *task;
@property (nonatomic) NSMutableOrderedSet *listTasks;

@property (weak, nonatomic) IBOutlet UIButton *lowButton;
@property (weak, nonatomic) IBOutlet UIButton *mediumButton;
@property (weak, nonatomic) IBOutlet UIButton *highButton;

@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@end



@implementation TaskCreationViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //self.listTasks = self.list.task.mutableCopy;
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
 
}


-(void)setupNavigationBar {
    self.navigationItem.title = @"Add To Do Item";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}


-(void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)save {
    
    self.task.taskDescription = self.taskTextField.text;
    
    self.task.createdAt = [NSDate date];
   
    self.task.list = self.list;
    
    //self.list.task = self.listTasks;
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
 
}


//- (IBAction)priorityButtonTapped:(UIButton *)sender {
//
//    if (sender == self.lowButton) {
//        [self.listTasks insertObject:self.task atIndex:self.listTasks.count];
//    } else if (sender == self.mediumButton) {
//        [self.listTasks insertObject:self.task atIndex:self.listTasks.count];
//        
//    } else if (sender == self.highButton) {
//        [self.listTasks insertObject:self.task atIndex:0];
//    }
//}

@end














































