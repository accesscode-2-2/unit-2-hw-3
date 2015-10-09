//
//  TaskCreateTableViewController.m
//  MarsWater
//
//  Created by Jamaal Sedayao on 10/6/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TaskCreateTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import <CoreData/CoreData.h>


@interface TaskCreateTableViewController ()

@property (nonatomic) Task *task;
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (nonatomic) NSMutableOrderedSet *taskForList;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation TaskCreateTableViewController

- (void) setupNavBar {
    
    self.navigationItem.title = @"New Task";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    self.datePicker.minimumDate = [NSDate date];
    
    self.taskForList = [[NSMutableOrderedSet alloc]init];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
}

- (void) save{
    
    self.task.taskDescription = self.taskTitleTextField.text;
    self.task.dueAt = [self.datePicker date];
    
    NSLog(@"Due Date: %@", self.task.dueAt);
    
    if (self.task.createdAt == nil) {
        
        self.task.createdAt = [NSDate date];
        
    }else {
        
        self.task.updatedAt = [NSDate date];
    }
    
    //create NSMutableOrderedSet in this view controller. I called mine NSMutableOrderedSet *taskForList;
    //set mutablecopy of self.list.task.mutableCopy equal to it
    self.taskForList = self.list.task.mutableCopy;

    //add self.task to NSMutableOrderedSet created in this view controller
    [self.taskForList addObject:self.task];
    
    //set NSOrderedSet (self.list.task) equal to the NSMutableOrderedSet created in this view controller
    self.list.task = self.taskForList;
    
    NSLog(@"self.list.tasks: %@",self.list.task);
    

    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.managedObjectContext save:nil];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
