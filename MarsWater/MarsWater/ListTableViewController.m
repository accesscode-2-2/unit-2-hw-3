//
//  ListTableViewController.m
//  MarsWater
//
//  Created by Jamaal Sedayao on 10/4/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListTableViewController.h"
#import "AppDelegate.h"
#import "List.h"

@interface ListTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    //1.create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"List"];
    
    //2. create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //3. set the sortdescriptors on the fetch request
    fetchRequest.sortDescriptors = @[sort];
    
    //4. create a fetchedResultsController with a fetchRequest and a managedObjectContext
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellIdentifier" forIndexPath:indexPath];
    
    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = list.title;
    cell.backgroundColor = (UIColor *)list.color;
    cell.detailTextLabel.text = [list.createdAt description];
    
    return cell;
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
}

@end
