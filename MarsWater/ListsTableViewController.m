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
#import "TaskTableViewController.h"

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
    
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
   
    [self.tableView reloadData];
}

#pragma mark - prepareForSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showListName"]) { // create reference to segue title
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; // for the selected row
        List *list = self.fetchedResultsController.fetchedObjects[indexPath.row]; // grab dictionary of stored items
        TaskTableViewController *detailController = segue.destinationViewController; // set destination viewController
        
        NSLog(@"%@", list);
        
          detailController.listName = list.title; // pass title from list dictionary to new viewController
          NSLog(@"%@", list.title);
          detailController.listColor = (UIColor *)list.color; // pass color from list dictionary to new viewController
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) { // delete rows
        
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else {
//        NSLog(@"Unhandled editing style! %d", editingStyle);
        
    }
}

@end

