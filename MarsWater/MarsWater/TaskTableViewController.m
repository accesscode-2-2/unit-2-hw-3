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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Task *selectedTask = self.list.task[indexPath.row];
    
    [self.delegate didSelectTask:selectedTask atIndexPath:self.selectedTaskIndexPath];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

#pragma mark - alert controller

-(void)showAlertActions{
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"What would you like to do?"
                                 message:@"Select One"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *markAsDone = [UIAlertAction
                                 actionWithTitle:@"Mark Done"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Give task a check mark image
                                     //Move task to bottom of list.task
                                     //change background color of cell
                                     //set task's completedAt property
                                     
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
    
    UIAlertAction *edit = [UIAlertAction
                           actionWithTitle:@"Edit"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               //push a taskCreationTableViewController
                               //add functionality on tCTVC to replace object at index?
                               
                               [view dismissViewControllerAnimated:YES completion:nil];
                               
                           }];
    
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:markAsDone];
    [view addAction:edit];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}


@end
