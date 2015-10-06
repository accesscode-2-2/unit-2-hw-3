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

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
//    
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:NO];
//    
//    fetchRequest.sortDescriptors = @[sort];
//    
//    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    
//    self.fetchedResultsController.delegate = self;
//    
//    [self.fetchedResultsController performFetch:nil];
//    
//    self.list.task = self.fetchedResultsController.fetchedObjects;
    
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
    cell.backgroundColor = (UIColor *)self.list.color;

    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    TaskCreationTableViewController *taskCreationTVC = segue.destinationViewController;
    taskCreationTVC.list = self.list;
}

@end
