//
//  ListsTableViewController.m
//  MarsWater
//
//  Created by Michael Kavouras on 10/4/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListsTableViewController.h"
#import "AppDelegate.h"
#import "List.h"
#import "TaskCreationViewController.h"

@interface ListsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ListsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCellIdentifier" forIndexPath:indexPath];
    
    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.backgroundColor = (UIColor *)list.color;
    cell.textLabel.text = list.title;
    cell.detailTextLabel.text = [list.createdAt description];
    
    if (list.task.count >= 1){
        cell.detailTextLabel.text = [NSString stringWithFormat: @"Tasks: %lu " ,list.task.count];
    }
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"TaskCreation"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TaskCreationViewController *vc = segue.destinationViewController;
        List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
        vc.list = list;
        
        NSLog(@"segue list %@", vc.list);
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObjectContext *context =
        [self.fetchedResultsController managedObjectContext];
        
        NSManagedObject *objectToBeDeleted =
        [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [context deleteObject:objectToBeDeleted];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.managedObjectContext save:nil];
        
        NSError *error = nil;
        if (![context save:&error])
        {
            NSLog(@"Error deleting movie, %@", [error userInfo]);
        }
        
        [self.tableView reloadData];
    }
}

@end

