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

@interface TasksTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

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
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    
    cell.titleLabel.text =  task.taskDescription ;
    
    
    NSDateFormatter *createdDateFormatter = [[NSDateFormatter alloc] init];
    [createdDateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    cell.createdAtLabel.text = [NSString stringWithFormat:@"Created at: %@",[createdDateFormatter stringFromDate:task.createdAt] ];
    
    NSDateFormatter *dueAtDateFormatter = [[NSDateFormatter alloc] init];
    [dueAtDateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    cell.dueAtLabel.text = [NSString stringWithFormat:@"Due at: %@",[dueAtDateFormatter stringFromDate:task.dueAt] ];
    
    cell.priorityLabel.text = [NSString stringWithFormat:@"Priority: %@",task.priority];;
    
    
    return cell;
}
- (IBAction)segmentSelected:(UISegmentedControl *)sender {
    [self.tableView reloadData];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *taskCTVC = (TaskCreationTableViewController *)([navController viewControllers][0]);
    
    
   taskCTVC.list = self.list;
     }

@end
