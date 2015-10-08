//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Xiulan Shi on 10/6/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TasksTableViewController.h"
#import "Task.h"
#import "AppDelegate.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createAt" ascending:NO];
    
    fetchRequest.sortDescriptors = @[sort];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task  = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:task.dueAt];
    
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}

@end
