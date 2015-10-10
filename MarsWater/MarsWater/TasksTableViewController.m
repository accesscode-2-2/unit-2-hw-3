//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Elber Carneiro on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TasksTableViewController.h"
#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "List.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSArray *tasks;
@property (nonatomic) UIBarButtonItem *addButton;

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // give a new action to our "+" button
    self.addButton = self.navigationItem.rightBarButtonItem;
    [self.addButton setTarget:self];
    [self.addButton setAction:@selector(newTask:)];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    List *list = self.fetchedResultsController.fetchedObjects[self.listIndex];
    NSLog(@"%@", list.task);
    self.tasks = [list.task allObjects];
    self.navigationItem.title = list.title;
    
    [self.tableView reloadData];
}

- (void)newTask:(id)sender {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *newTaskNC = [main instantiateViewControllerWithIdentifier:@"newTaskNav"];
    
    TaskCreationTableViewController *taskCreationTVC = (TaskCreationTableViewController *)[newTaskNC topViewController];
    
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"newTaskSegue" source:self destination:newTaskNC performHandler:^{
        
        taskCreationTVC.listIndex = self.listIndex;
        [self presentViewController:newTaskNC animated:YES completion:nil];
    
    }];
    
    [self prepareForSegue:segue sender:self];
    [segue perform];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.tasks[indexPath.row] taskDescription];
    
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}

@end
