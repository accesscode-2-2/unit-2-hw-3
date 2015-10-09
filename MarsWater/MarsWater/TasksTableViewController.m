//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Umar on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//


#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "TasksTableViewController.h"
#import "Task.h"
#import "List.h"
#import "ListsTableViewController.h"

@interface TasksTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSMutableOrderedSet *allTasks;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) Task *task;
@property (nonatomic) NSMutableArray *tasksGroup;


@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tasksGroup = [NSMutableArray arrayWithArray:[self.nextIndexPath.task array]];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // 1) create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.nextIndexPath.task.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskIdentifier" forIndexPath:indexPath];
    
//    Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
//    cell.textLabel.text = task.taskDescription;
    
    Task *task = self.nextIndexPath.task[indexPath.row];
    cell.textLabel.text = task.taskDescription;

    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}

@end
