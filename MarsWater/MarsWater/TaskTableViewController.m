//
//  TaskTableViewController.m
//  MarsWater
//
//  Created by Justine Gartner on 10/5/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TaskTableViewController.h"
#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface TaskTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSMutableOrderedSet *listTasks;

@end

@implementation TaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.list.title;
    
    [self.tableView reloadData];
    
    self.tableView.backgroundColor = self.list.color;
    self.tableView.backgroundView.backgroundColor = self.list.color;
}

-(void)viewWillAppear:(BOOL)animated{
    
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


#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *taskCreationTVC = (TaskCreationTableViewController *)([navController viewControllers][0]);
    taskCreationTVC.list = self.list;
}

#pragma mark - NSManagedObjectContext

-(void)removeObjectFromNSManagedObjectContext:(Task *)selectedTask {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    [context deleteObject:selectedTask];
    [context processPendingChanges];
    
}


@end
