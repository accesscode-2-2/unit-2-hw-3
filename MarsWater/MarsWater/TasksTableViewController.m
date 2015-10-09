//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Charles Kang on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TasksTableViewController.h"
#import "TaskCreationTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Task.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSMutableOrderedSet *listTasks;
//@property (nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Tasks";
    self.navigationItem.title = self.list.title;
    
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.task.count
    ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    
    cell.textLabel.text = task.taskDescription;
    cell.backgroundColor = self.list.color;
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Task *selectedTask = self.list.task[indexPath.row];
        [self removeObjectFromNSManagedObjectContext:selectedTask];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}

-(void)removeObjectFromNSManagedObjectContext:(Task *)selectedTask {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    [context deleteObject:selectedTask];
    [context processPendingChanges];
    
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *taskCreationTVC = (TaskCreationTableViewController *)([navController viewControllers][0]);
    taskCreationTVC.list = self.list;
}

#pragma mark - Core Data

-(void)removeObjectFromCoreDataContext:(Task *)selectedTask {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    [context deleteObject:selectedTask];
    [context processPendingChanges];
    
}

-(void)pushTasksCreationTableViewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TasksTableViewController *tasksCreationVC = [storyboard instantiateViewControllerWithIdentifier:@"tasksCreationTableViewController"];
    
    [self.navigationController pushViewController:tasksCreationVC animated:YES];
    
}

@end
