//
//  ListsTableViewController.m
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/4/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//

#import "ListsTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "List.h"
#import "TasksTableViewController.h"
#import "ListCreationTableViewController.h"

@interface ListsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ListsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    /*
     //1) Fetching using a FetchRequest
     
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
     [fetchRequest setEntity:entity];
     
     // Specify how the fetched objects should be sorted
     NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES];
     
     [fetchRequest setSortDescriptors:@[sortDescriptor]];
     
     NSError *error = nil;
     NSArray *fetchedObjects = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
     if (fetchedObjects == nil) {
     NSLog(@"Could not fetch List Objects.");
     NSLog(@"%@ %@", error, error.localizedDescription);
     }
     */
    //2) Fetching using a Fetched Results Controller (pro: has delegate methods)
    
    //create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    //create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //set the sort descriptor on the fetch request
    fetchRequest.sortDescriptors = @[sort];
    
    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    fetchedResultsController.delegate = self;
    
    self.fetchedResultsController = fetchedResultsController;
    
    NSError *error = nil;
    if(![self.fetchedResultsController performFetch:nil])
    {
        NSLog(@"Could not fetch List Objects.");
        
        NSLog(@"%@ %@", error, error.localizedDescription);
    }
    else
    {
        [self.tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)setupNavBar
{
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.0/255 green:118.0/255 blue:255.0/255 alpha:1.0];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellID" forIndexPath:indexPath];
    
    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = list.title;
    cell.detailTextLabel.text = [list subtitleText];
    cell.backgroundColor = (UIColor *)list.color;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        List *list = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [delegate.managedObjectContext deleteObject:list];
    }
}


#pragma mark - NSFetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            
            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
        default:
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowTasks"])
    {
        TasksTableViewController *tvc = (TasksTableViewController *)segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        List *list = [self.fetchedResultsController objectAtIndexPath:indexPath];
        tvc.listAtIndexPath = list;
        tvc.indexPath = indexPath;
    }
}

@end
