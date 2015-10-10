//
//  TasksDetailTableViewController.m
//  MarsWater
//
//  Created by Eric Sze on 10/7/15.
//  Copyright © 2015 myApps. All rights reserved.
//

#import "TasksDetailTableViewController.h"
#import "TaskCreationViewController.h"
#import <CoreData/CoreData.h>

@interface TasksDetailTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TasksDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self fetchResults];
}

- (void)setupNavigationBar {
    // set the title
    // set the left bar to cancel
    // set the right button to add task
    
    self.navigationItem.title = @"Tasks";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTask)];
}

- (void)cancel {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addTask {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TaskCreationViewController *taskCreationVC = [storyboard instantiateViewControllerWithIdentifier:@"TaskCreationIdentifier"];
    taskCreationVC.list = self.list;
    
    // must instantiate view controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:taskCreationVC];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

- (void)fetchResults {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // Steps to create a fetch request:
    // 1) Create an instance of NSFetchRequest with the entity name in .xcdatamodeld
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    // 2) Specify criteria for filtering which objects to fetch Create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:NO];
    
    // 3) Specify how the fetched objects should be sorted // Set the sortDescriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    // 4) Create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

// set delegate for fetchedResultsController here?
    self.fetchedResultsController.delegate = self;
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
    
}

@end
