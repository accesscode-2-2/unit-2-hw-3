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

@interface TaskTableViewController ()

@property (nonatomic) Task *selectedTask;

@end

@implementation TaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.list.title;
    
    //[self.tableView reloadData];
    
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];

    NSString *formattedDateString = [dateFormatter stringFromDate:task.completedAt];
    NSString *completedOnString = [NSString stringWithFormat:@"Completed on: %@", formattedDateString];
    
    cell.textLabel.text = task.taskDescription;
    cell.backgroundColor = self.list.color;
    
    UIImage *checkmark = [UIImage imageNamed:@"checkmark"];
    
    if (task.completedAt == nil) {
        
        cell.detailTextLabel.text = @"";
        cell.imageView.image = nil;
        
    }else {
        
        cell.imageView.image = checkmark;
        cell.detailTextLabel.text = completedOnString;
    }
    
    
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
    
    self.selectedTask = self.list.task[indexPath.row];
    
    [self showAlertActionsForSelectedTask:self.selectedTask atIndexPathRow:indexPath.row];
    
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

-(void)showAlertActionsForSelectedTask: (Task *)selectedTask atIndexPathRow: (NSInteger)indexPathRow{
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"What would you like to do?"
                                 message:@"Select One"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *markAsDone = [UIAlertAction
                                 actionWithTitle:@"Mark Done"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Give task a completedAt property
                                     
                                     selectedTask.completedAt = [NSDate date];
                                     
                                     //Move task to bottom of list.task
                                     
                                     NSMutableIndexSet *movedTaskIndex = [[NSMutableIndexSet alloc] init];
                                     [movedTaskIndex addIndex:indexPathRow];
                                     
                                     NSMutableOrderedSet *listTasks = self.list.task.mutableCopy;
                                     
                                     [listTasks moveObjectsAtIndexes:movedTaskIndex toIndex:self.list.task.count - 1];
                                     
                                     self.list.task = listTasks;
                                     
                                     [self.tableView reloadData];
                                     
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
    
    UIAlertAction *edit = [UIAlertAction
                           actionWithTitle:@"Edit"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               
                               selectedTask.completedAt = nil;
                               
                               [self pushTaskCreationTableViewControllerWithSelectedTask:selectedTask atIndexPathRow:indexPathRow];
                               
                               [self.tableView reloadData];
                               
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

-(void)pushTaskCreationTableViewControllerWithSelectedTask:(Task *)selectedTask atIndexPathRow: (NSInteger)indexPathRow {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TaskCreationTableViewController *taskCreationTVC = [storyboard instantiateViewControllerWithIdentifier:@"taskCreationTableViewController"];
    taskCreationTVC.list = self.list;
    taskCreationTVC.selectedTask = selectedTask;
    taskCreationTVC.selectedTaskIndexPathRow = indexPathRow;
    
    [self.navigationController pushViewController:taskCreationTVC animated:YES];

}


@end
