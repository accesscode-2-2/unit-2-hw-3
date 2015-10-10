//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Xiulan Shi on 10/6/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TasksTableViewController.h"
#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface TasksTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSMutableOrderedSet *listTasks;

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.list.title;
    
    [self.tableView reloadData];
    
    self.tableView.backgroundColor = self.list.color;
    self.tableView.backgroundView.backgroundColor = self.list.color;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.list.task.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    
    cell.textLabel.text = task.taskDescription;
    cell.backgroundColor = self.list.color;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:task.dueAt];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Task *selectedTask = self.list.task[indexPath.row];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
         [delegate.managedObjectContext deleteObject:selectedTask];
         [delegate.managedObjectContext save:nil];
        [self.tableView reloadData];
    }
}


#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *taskCreationTVC = (TaskCreationTableViewController *)([navController viewControllers][0]);
 
    taskCreationTVC.list = self.list;
}



@end