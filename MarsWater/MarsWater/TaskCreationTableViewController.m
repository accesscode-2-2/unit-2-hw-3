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

@property (nonatomic) Task *task;

@property (nonatomic) NSMutableArray *listTasks;

@end

@implementation TaskCreationTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
    [self.listTasks addObject:self.task];
    
    self.list.task = self.listTasks;
    
}

-(void)setupNavigationBar{
    
    self.navigationItem.title = [NSString stringWithFormat:@"Add New Task to %@", self.list.title];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save{
    
    self.task.taskDescription = self.taskTextField.text;
    
    if (self.task.createdAt == nil) {
        
        self.task.createdAt = [NSDate date];
        
    }else {
        
        self.task.updatedAt = [NSDate date];
    }
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@", self.task);
}

- (IBAction)priorityButtonTapped:(UIButton *)sender {
    
    NSLog(@"priority button tapped");
    

}


@end
