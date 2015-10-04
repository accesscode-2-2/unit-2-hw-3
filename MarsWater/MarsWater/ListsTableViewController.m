//
//  ListsTableViewController.m
//  MarsWater
//
//  Created by Jackie Meggesto on 10/4/15.
//  Copyright © 2015 Jackie Meggesto. All rights reserved.
//

#import "ListsTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "List.h"

@interface ListsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController* fetchedResultsController;



@end

@implementation ListsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"createdAt" ascending:NO];
    
    fetchRequest.sortDescriptors = @[ sort];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    

    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self. fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellIdentifier" forIndexPath:indexPath];

    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    
    cell.textLabel.text = list.title;
    cell.detailTextLabel.text = list.createdAt.description;
    cell.backgroundColor = list.color;
    
    
    return cell;
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [self.tableView reloadData];
}


@end
