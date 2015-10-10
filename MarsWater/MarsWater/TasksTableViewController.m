//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Lauren Caponong on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TasksTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // 1) create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    
    // 2) create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    // 3) set the sortDescriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    // 4) create a fetchedResultsController with a fetchRequest and a managedObjectContext,
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];

//    cell.backgroundColor = (UIColor *)task.color;
    
    cell.textLabel.text = task.taskDescription;
    
    NSString *taskCreatedAtTime = [task.createdAt description];
    cell.detailTextLabel.text = taskCreatedAtTime;
    
    return cell;
}



- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}




@end