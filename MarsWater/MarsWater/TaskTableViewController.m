//
//  TaskTableViewController.m
//  MarsWater
//
//  Created by Christian Maldonado on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskTableViewController.h"
#import <CoreData/CoreData.h>
#import "ListsTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import "List.h"
#import "TaskCreationDelegate.h"
#import "TableCreationViewController.h"

@interface TaskTableViewController ()

<TaskCreationDelegate,
NSFetchedResultsControllerDelegate
>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    fetchedResultsController.delegate = self;
    
    self.fetchedResultsController = fetchedResultsController;
    
    [fetchedResultsController performFetch:nil];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(void)didCreateTask:(Task *)task{
    self.list = [self.fetchedResultsController objectAtIndexPath:self.indexPath];
    NSMutableOrderedSet *mutableSet = [self.list mutableOrderedSetValueForKey:@"task"];
    [mutableSet addObject:task];
    
    [self.list setValue:mutableSet forKey:@"task"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.task.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    cell.detailTextLabel.text = [task.createdAt description];
    
    
    
    return cell;
    

}


 - (void)shouldReloadData {
     [self.tableView reloadData];
 }
#pragma mark - navigation


- (IBAction)moveToTaskCreationPageButton:(UIBarButtonItem *)sender {
    
    TableCreationViewController *tableCreationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TableCreationVC"];
    tableCreationVC.delegate = self;
    
    [self.navigationController pushViewController:tableCreationVC animated:YES];
    
}


@end
