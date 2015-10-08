//
//  ListTableViewController.m
//  MarsWater
//
//  Created by Justine Gartner on 10/4/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListTableViewController.h"
#import "TaskTableViewController.h"
#import "AppDelegate.h"
#import "List.h"

@interface ListTableViewController ()<NSFetchedResultsControllerDelegate>

@property(nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    //Create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    //create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //set the sort descriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        List *selectedList = self.fetchedResultsController.fetchedObjects[indexPath.row];
        [self removeObjectFromCoreDataContext:selectedList];
        
    }
    
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"TaskSegueIdentifier"]){
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        TaskTableViewController *taskTVC = segue.destinationViewController;
        
        List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
        
        taskTVC.list = list;
        
        NSLog(@"taskTVC.list: %@", taskTVC.list);
    }
    
}

#pragma mark - Core Data

-(void)removeObjectFromCoreDataContext:(List *)selectedList {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    [context deleteObject:selectedList];
    [context processPendingChanges];
    
}


@end
