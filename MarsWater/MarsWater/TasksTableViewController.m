//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Elber Carneiro on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TasksTableViewController.h"
#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "List.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSArray *tasks;
@property (nonatomic) UIBarButtonItem *addButton;

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // give a new action to our "+" button
    self.addButton = self.navigationItem.rightBarButtonItem;
    [self.addButton setTarget:self];
    [self.addButton setAction:@selector(newTask:)];
    
    // build our fetch request and create our fetchedResultsController
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    // use the fetched data to populate our tableview
    [self buildTasksForTableView];
    
}

// this needs to be called every time the data in the database changes since our
// self.tasks property is a sorted copy of the data in the mysql database
- (void)buildTasksForTableView {
    
    List *list = self.fetchedResultsController.fetchedObjects[self.listIndex];
    NSArray *temp = [list.task allObjects];
    
    NSSortDescriptor *sortDate = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    self.tasks = [temp sortedArrayUsingDescriptors:@[sortDate]];
    NSLog(@"self.tasks: %@", self.tasks);
    self.navigationItem.title = list.title;
}

- (void)newTask:(id)sender {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *newTaskNC = [main instantiateViewControllerWithIdentifier:@"newTaskNav"];
    
    TaskCreationTableViewController *taskCreationTVC = (TaskCreationTableViewController *)[newTaskNC topViewController];
    
    // create a custom segue and use it to pass the listIndex to the next view controller
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"newTaskSegue" source:self destination:newTaskNC performHandler:^{
        
        taskCreationTVC.listIndex = self.listIndex;
        [self presentViewController:newTaskNC animated:YES completion:nil];
    
    }];

    [segue perform];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.tasks[indexPath.row] taskDescription];
    cell.detailTextLabel.text = [[self.tasks[indexPath.row] createdAt] description];
    
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate method

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    // we  need to update our self.tasks property to reflect the changes in the database
    
    [self buildTasksForTableView];
    
    [self.tableView reloadData];
}

@end
