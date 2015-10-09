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

@property (nonatomic) NSMutableArray<Task *> *tasksArray;
@end

@implementation TasksTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavBar];
    self.tableView.rowHeight = 100;
    
    self.tasksArray = [NSMutableArray arrayWithArray:[self.listAtIndexPath.tasks array]];
    NSLog(@"Tasks Array Count: %lu",(unsigned long)self.tasksArray.count);
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    ////create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    //create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //set the sort descriptor on the fetch request
    fetchRequest.sortDescriptors = @[sort];
    
    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
    NSFetchedResultsController *fetchedResutlsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    fetchedResutlsController.delegate = self;
    
    self.fetchedResultsController = fetchedResutlsController;
    
    NSError *error = nil;
    if(![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Could not Load Task Entity");
        NSLog(@"%@ %@",error, error.localizedDescription);
    }else{
        self.list = [self.fetchedResultsController objectAtIndexPath:self.indexPath];
        [self.tableView reloadData];
    }
    //    }else
    //    {
    //        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //        self.list = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //        [self.tableView reloadData];
    //    }
    
}

- (void)setupNavBar
{
    self.navigationItem.title = @"Tasks";
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.0/255 green:118.0/255 blue:255.0/255 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listAtIndexPath.tasks.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TasksCellID" forIndexPath:indexPath];
    
    //Task *task = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //List *list = [self.fetchedResultsController objectAtIndexPath:self.indexPath ];
    if(self.listAtIndexPath.tasks.count > 0){
        Task *task = self.listAtIndexPath.tasks[indexPath.row];
        cell.textLabel.text = task.taskDescription;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //        //AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        //        List *list= self.listAtIndexPath;
        //
        //
        //        Task *task = list.tasks[indexPath.row];
        //
        //        //might need to change this to delegate.context
        //        [task.managedObjectContext deleteObject:task];
        
        //Task *task = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        List *list = [self.fetchedResultsController objectAtIndexPath:self.indexPath];
        Task *task = [list.tasks objectAtIndex:indexPath.row];
        NSMutableOrderedSet *ms = [list mutableOrderedSetValueForKey:@"tasks"];
        [ms removeObject:task];
        self.listAtIndexPath.tasks = ms;
        //        NSMutableOrderedSet *set = list.tasks.mutableCopy;
        //        [set removeObjectAtIndex:indexPath.row];
        //        list.tasks = set;
        
        // NSArray<Task *> tasksArray =
        //        NSMutableArray<Task *> *taskArray = [NSMutableArray arrayWithArray:[list.tasks array]];
        //
        //        [taskArray removeObject:task];
        //        NSOrderedSet *set = [[NSOrderedSet alloc] initWithArray:taskArray];
        
        [list setValue:ms forKey:@"tasks"];
        
        [delegate.managedObjectContext deleteObject:task];
        
        [delegate.managedObjectContext save:nil];
        
        [self.tableView reloadData];
        
        
    }
    
}

- (IBAction)addTasksButtonTapped:(UIBarButtonItem *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Task" message:@"Please Enter A New Task" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField){
        textField.placeholder = NSLocalizedString(@"Enter Task", @"NewTaskPlaceHolder");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                               {
                                   AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                                   
                                   List *list = [self.fetchedResultsController objectAtIndexPath:self.indexPath];
                                   
                                   Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
                                   
                                   
                                       task.taskDescription = alertController.textFields.firstObject.text;
                                       task.createdAt = [NSDate date];
                                       
                                       
                                       NSMutableOrderedSet *ms = [list mutableOrderedSetValueForKey:@"tasks"];
                                       [ms addObject:task];
                                       self.listAtIndexPath.tasks = ms;
                                       
                                       [list setValue:ms forKey:@"tasks"];
                                       
                                       [delegate.managedObjectContext insertObject:task];
                                       
                                       [delegate.managedObjectContext save:nil];
                                       
                                       [self.tableView reloadData];
                                       
                                       
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - <NSFetchedResultsControllerDelegate>

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView beginUpdates];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
//
//    switch (type) {
//        case NSFetchedResultsChangeDelete: {
//            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
//            break;
//        }
//        case NSFetchedResultsChangeInsert: {
//            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
//            break;
//        }
//        case NSFetchedResultsChangeUpdate: {
//            [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
//            break;
//        }
//        case NSFetchedResultsChangeMove:{
//            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
//            break;
//        }
//        default: {
//            break;
//        }
//    }
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView endUpdates];
//}

@end
