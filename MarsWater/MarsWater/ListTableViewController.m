//
//  ListTableViewController.m
//  MarsWater
//
//  Created by Justine Gartner on 10/4/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListCreationTableViewController.h"
#import "ListTableViewController.h"
#import "TaskTableViewController.h"
#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "List.h"

@interface ListTableViewController ()<NSFetchedResultsControllerDelegate>

@property(nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic)List *selectedList;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    //Create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    //create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //set the sort descriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellIdentifier" forIndexPath:indexPath];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:list.createdAt];
    NSString *createdAtString = [NSString stringWithFormat:@"Created on: %@", formattedDateString];
    
    cell.textLabel.text = list.title;
    cell.detailTextLabel.text = createdAtString;
    cell.backgroundColor = (UIColor *)list.color;
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        List *selectedList = self.fetchedResultsController.fetchedObjects[indexPath.row];
        [self removeObjectFromNSManagedObjectContext:selectedList];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedList = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    [self showAlertActionsForSelectedList:self.selectedList];
    
}


#pragma mark - NSFetchedResultsControllerDelegate protocols

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
}


#pragma mark - NSManagedObjectContext

-(void)removeObjectFromNSManagedObjectContext:(List *)selectedList {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    [context deleteObject:selectedList];
    [context processPendingChanges];
    
}


#pragma mark - alert controller

-(void)showAlertActionsForSelectedList: (List *)selectedList {
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"What would you like to do?"
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *addTask = [UIAlertAction
                                 actionWithTitle:@"Add Task"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [self goToTasksForList:selectedList];
                                     
                                     [self.tableView reloadData];
                                     
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
    
    UIAlertAction *edit = [UIAlertAction
                           actionWithTitle:@"Edit List"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               
                               [self editSelectedList:selectedList];
                               
                               [self.tableView reloadData];
                               
                               [view dismissViewControllerAnimated:YES completion:nil];
                               
                           }];
    
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:addTask];
    [view addAction:edit];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}

#pragma mark - push listCreationTableViewController for selected list

-(void)editSelectedList:(List *)selectedList {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ListCreationTableViewController *listCreationTVC = [storyboard instantiateViewControllerWithIdentifier:@"listCreationTableViewController"];
    listCreationTVC.selectedList = selectedList;
    
    [self.navigationController pushViewController:listCreationTVC animated:YES];
    
}

-(void)goToTasksForList:(List *)selectedList{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TaskTableViewController *taskTVC = [storyboard instantiateViewControllerWithIdentifier:@"taskTableViewController"];
    taskTVC.list = selectedList;

    
    [self.navigationController pushViewController:taskTVC animated:YES];
    
}





@end
