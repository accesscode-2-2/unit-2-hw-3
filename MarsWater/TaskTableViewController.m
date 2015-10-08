//
//  TaskTableViewController.m
//  MarsWater
//
//  Created by Shena Yoshida on 10/6/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskTableViewController.h"
#import <CoreData/CoreData.h>
#import "TaskCreateViewController.h"

@interface TaskTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TaskTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    [self fetchResults];
}

-(void)setupNavigationBar
{
    self.navigationItem.title = self.list.title;
    
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
    
    TaskCreateViewController *createVC = [storyboard instantiateViewControllerWithIdentifier:@"TaskCreateIdentifier"];
    createVC.list = self.list;
    
    //    Here's another way to add a UINavigationController:
    //    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationItem"];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:createVC];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)fetchResults
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate; // set delegate
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"]; // create fetch request instance for tasks
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"priority" ascending:NO]; //create sort descriptor, sort by priority
    
    fetchRequest.sortDescriptors = @[sort]; // have fetched items organized by sort descriptor
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"list.title == %@", self.list.title]; // set task predicate to individual list
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil]; // create fetch request controller and set to our fetchRequest (tasks)
    
    self.fetchedResultsController.delegate = self; // set delegate for fetchRequestController
    
    [self.fetchedResultsController performFetch:nil]; // perform fetch
    
    [self.tableView reloadData]; // reload table view
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count; // number of fetched items in memory
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath // this method reloads table after item is added
{
    [self.tableView reloadData];
}

@end
