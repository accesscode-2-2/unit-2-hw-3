//
//  TaskTableViewController.m
//  MarsWater
//
//  Created by Shena Yoshida on 10/6/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskTableViewController.h"
#import <CoreData/CoreData.h>

@interface TaskTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self fetchResults];
  //  [self.tableView reloadData];
    
}

-(void)setupNavigationBar
{
    self.navigationItem.title = self.listName;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewItem)];
}

- (void)cancel
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createNewItem
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationItem"];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)fetchResults
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = task.taskDescription; 
    
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath { // this method reloads table after item is added
    
    [self.tableView reloadData];
}

@end
