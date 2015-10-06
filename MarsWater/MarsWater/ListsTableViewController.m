//
//  ListsTableViewController.m
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/4/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//

#import "ListsTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "List.h"
#import "TasksTableViewController.h"

@interface ListsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) List *list;

@end

@implementation ListsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellID" forIndexPath:indexPath];
    
    self.list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = self.list.title;
    cell.detailTextLabel.text = [self.list.createdAt description];
    cell.backgroundColor = (UIColor *)self.list.color;
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.list = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.list.managedObjectContext deleteObject:self.list];
        //[self.document updateChangeCount:UIDocumentChangeDone];
       // [self saveNotes];
    }
}


#pragma mark - NSFetchedResultsController Delegate Methods
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TasksTableViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskTVC"];
    tvc.tasks = [NSMutableArray new];
    
    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    
    NSArray<Task *> *tasksArray = [list.tasks array];
    Task *task = [tasksArray firstObject];
    NSArray *commaSeparatedTasks = [task.taskDescription componentsSeparatedByString:@","];
    NSLog(@"%@",commaSeparatedTasks);
    
    NSMutableArray *mutableTasksArray = [NSMutableArray arrayWithArray:commaSeparatedTasks];
    
    for(NSString *taskString in mutableTasksArray){
        [tvc.tasks addObject:taskString];
    }
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
