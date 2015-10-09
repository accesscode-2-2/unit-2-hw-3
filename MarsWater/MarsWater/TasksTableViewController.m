//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Henna on 10/9/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "TasksTableViewController.h"
#import <CoreData/CoreData.h>
#import "NewTaskViewController.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>
    @property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self fetchResults];
}

-(void)setupNavigationBar
{
    self.navigationItem.title = self.list.title;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewTask)];
}

- (void)cancel
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createNewTask
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewTaskViewController *newTaskVC = [storyboard instantiateViewControllerWithIdentifier:@"NewTaskVCIdentifier"];
    newTaskVC.list = self.list;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newTaskVC];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)fetchResults
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"createdAt" ascending:NO];
    
    fetchRequest.sortDescriptors = @[sort];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"list.title == %@", self.list.title];
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

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath // this method reloads table after item is added
{
    [self.tableView reloadData];
}


@end
