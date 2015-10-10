//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Charles Kang on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TasksTableViewController.h"
#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface TasksTableViewController ()

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationItem.title = @"Tasks";
    //    self.navigationItem.title = self.list.title;
    
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
    
    return cell;
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *taskCreationTVC = (TaskCreationTableViewController
                                                        *)([navController viewControllers][0]);
    taskCreationTVC.list = self.list;
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView reloadData];
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//    }
//}


@end
