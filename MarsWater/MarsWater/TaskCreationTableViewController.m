//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Elber Carneiro on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationTableViewController.h"
#import "AppDelegate.h"
#import "List.h"
#import "Task.h"

@interface TaskCreationTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) Task *task;
@property (nonatomic) List *list;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSOrderedSet *tasks;

@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    self.list = self.fetchedResultsController.fetchedObjects[self.listIndex];
    NSLog(@"%@", self.list.task);
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"New Task";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    self.task.taskDescription = self.descriptionTextField.text;
    self.task.createdAt = [NSDate date];
    
    NSMutableSet *tasks = [[NSMutableSet alloc] init];
    
    if (self.list.task != nil) {
        tasks = [NSMutableSet setWithSet:self.list.task];
    } else {
        tasks = [self.list mutableSetValueForKey:@"task"];
    }
    [tasks addObject:self.task];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
