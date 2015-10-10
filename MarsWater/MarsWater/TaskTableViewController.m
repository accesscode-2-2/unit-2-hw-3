//
//  TaskTableViewController.m
//  MarsWater
//
//  Created by Brian Blanco on 10/9/15.
//  Copyright © 2015 Brian Blanco. All rights reserved.
//

#import "TaskTableViewController.h"
#import "TaskCreateTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface TaskTableViewController ()

@end

@implementation TaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.task.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    
    cell.textLabel.text = task.taskDescription;
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navigationController = segue.destinationViewController;
    
    TaskCreateTableViewController *taskController = (TaskCreateTableViewController*)([navigationController viewControllers][0]);
    taskController.list = self.list;
}




@end
