//
//  TaskTableViewController.m
//  MarsWater
//
//  Created by Zoufishan Mehdi on 10/8/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

#import "TaskTableViewController.h"
#import "TaskCreationViewController.h"
#import "List.h"
#import "AppDelegate.h"
#import "Task.h"
#import <CoreData/CoreData.h>

@interface TaskTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (nonatomic) NSMutableOrderedSet *listTasks;

@end



@implementation TaskTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self fetchResults];
    
    //[self.tableView reloadData];
    
    
//    self.tableView.backgroundColor = self.list.color;
//    self.tableView.backgroundView.backgroundColor = self.list.color;
}

-(void)setupNavigationBar {
    self.navigationItem.title = self.list.title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
}


-(void)addNewItem {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TaskCreationViewController *taskCreationVC = [storyboard instantiateViewControllerWithIdentifier:@"TaskCreationIdentifier"];
    taskCreationVC.list = self.list;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:taskCreationVC];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}



-(void)cancel {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//-(void)viewWillAppear:(BOOL)animated{
//    
//    [self.tableView reloadData];
//}


-(void)fetchResults {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"priority" ascending:NO];
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
    //return self.fetchedResultsController.fetchedObjects.count;
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCellIdentifier" forIndexPath:indexPath];
    
    //Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
     Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = task.taskDescription;
//    cell.backgroundColor = self.list.color;
    
    return cell;
}


//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return YES;
//}



//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        Task *selectedTask = self.fetchedResultsController.fetchedObjects[indexPath.row];
//   
//        //Task *selectedTask = self.list.task[indexPath.row];
//        
//       [self removeObjectFromNSManagedObjectContext:selectedTask];
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//    }
//    
//}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    UINavigationController *navController = segue.destinationViewController;
//    
//    TaskCreationViewController *taskCreationVC = (TaskCreationViewController *)([navController viewControllers][0]);
//    taskCreationVC.list = self.list;
//}


#pragma mark - NSManagedObjectContext
         
// -(void)removeObjectFromNSManagedObjectContext:(Task *)selectedTask {
//             
//       AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//       NSManagedObjectContext *context = delegate.managedObjectContext;
//       [context deleteObject:selectedTask];
//       [context processPendingChanges];
//
// }



         
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
    
}

         
@end
