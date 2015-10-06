//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/5/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//

#import "TasksTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Task.h"
#import "List.h"
@interface TasksTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) Task *task;
@property (nonatomic) List *list;
@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Tasks";
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    //create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    //create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //set the sort descriptor on the fetch request
    fetchRequest.sortDescriptors = @[sort];
    
    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    self.list = [self.fetchedResultsController.fetchedObjects firstObject];
    
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TasksCellID" forIndexPath:indexPath];
    
    
    Task *task = self.tasks[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.list = [self.fetchedResultsController.fetchedObjects firstObject];
        self.task = self.list.tasks[indexPath.row];
        [self.task.managedObjectContext deleteObject:self.task];
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
    
}

- (IBAction)addTasksButtonTapped:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Task" message:@"Please Enter A New Task" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = NSLocalizedString(@"Enter Task", @"NewTaskPlaceHolder");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
        self.task.taskDescription = alertController.textFields.firstObject.text;
        [self.tasks addObject:self.task];
        
        NSMutableOrderedSet *mutableSet = (NSMutableOrderedSet *)self.list.tasks;
        [mutableSet addObject:self.task];
        self.list.tasks = (NSOrderedSet *)mutableSet.copy;
        
        [self.tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - <NSFetchedResultsControllerDelegate>

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
}


@end
