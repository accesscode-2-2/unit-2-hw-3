//
//  TasksDetailTableViewController.m
//  MarsWater
//
//  Created by Eric Sze on 10/7/15.
//  Copyright © 2015 myApps. All rights reserved.
//

#import "TasksDetailTableViewController.h"

@interface TasksDetailTableViewController ()

@end

@implementation TasksDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
//    [self fetchResults];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)setupNavigationBar {
    // set the title
    // set the left bar to cancel
    // set the right button to add task
    
    self.navigationItem.title = @"Tasks";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTask)];
}

- (void)cancel {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//- (void)addTask {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    TaskCreationViewController *taskCreationVC = [storyboard instantiateViewControllerWithIdentifier:@"TaskCreationIdentifier"];
////    taskCreationVC.list = self.list;
//    
//    // must instantiate view controller
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:taskCreationVC];
//    
//    [self presentViewController:navigationController animated:YES completion:nil];
//    
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.task.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    
    return cell;
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    TaskCreationViewController *taskCreationVC = (TaskCreationViewController
                                                        *)([navController viewControllers][0]);
    taskCreationVC.list = self.list;
}

//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
//    
//    [self.tableView reloadData];
//    
//}





@end
