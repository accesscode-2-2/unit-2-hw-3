//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Diana Elezaj on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TasksTableViewController.h"
#import "Task.h"
#import "TaskCreationTableViewController.h"
#import "CustomTableViewCell.h"

@interface TasksTableViewController ()

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return self.list.task.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    
    cell.textLabel.text = task.taskDescription;
//    cell.detailTextLabel.text = [task.createdAt description];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Due at: %@",[dateFormatter stringFromDate:task.dueAt] ];
    
    
    NSLog(@"task %@", task);
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *taskCTVC = (TaskCreationTableViewController *)([navController viewControllers][0]);
    
    
   taskCTVC.list = self.list;
     }

@end
