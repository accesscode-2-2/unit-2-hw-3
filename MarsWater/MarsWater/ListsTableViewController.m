//
//  ListsTableViewController.m
//  MarsWater
//
//  Created by Eric Sze on 10/4/15.
//  Copyright © 2015 myApps. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "ListsTableViewController.h"
#import "AppDelegate.h"
#import "List.h"
#import "TasksDetailTableViewController.h"

@interface ListsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ListsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // Steps to create a fetch request:
    // 1) Create an instance of NSFetchRequest with the entity name in .xcdatamodeld
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    // 2) Specify criteria for filtering which objects to fetch Create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    // 3) Specify how the fetched objects should be sorted // Set the sortDescriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    // 4) Create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    // 5) Perform the fetch
    [self.fetchedResultsController performFetch:nil];
    
    // after you fetch, you want to reload the data
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellIdentifier" forIndexPath:indexPath];
    
    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = list.title;
    cell.detailTextLabel.text = [list.createdAt description];
    cell.backgroundColor = (UIColor *)list.color;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tasksDetailSegue"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        // takes the information of the selected row in List
        List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
        // send this information to the desired view controller (TasksDetailTableViewController)
        // but only after you import the file
        TasksDetailTableViewController *tasksDetailTVC = segue.destinationViewController;
        // information passed
        tasksDetailTVC.list = list;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
    
}


// Delete cells from UITableView
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // takes entire dictionary
        List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
        // set the delegate
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.managedObjectContext deleteObject:list];
        [delegate.managedObjectContext save:nil];
    }
}


@end
