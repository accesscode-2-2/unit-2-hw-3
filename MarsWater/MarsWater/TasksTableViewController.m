//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Umar on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TasksTableViewController.h"
#import "Task.h"
#import "TaskCreationTableViewController.h"

@interface TasksTableViewController ()

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    cell.detailTextLabel.text = [task.createdAt description];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *vc = (TaskCreationTableViewController *)([navController viewControllers][0]);
    vc.list = self.list;
}

@end
