//
//  TaskCreationTableViewController.m
//  MarsWater
//
//  Created by Felicia Weathers on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationTableViewController.h"

@interface TaskCreationTableViewController ()
<
NSFetchedResultsControllerDelegate
>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TaskCreationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
}

- (IBAction)saveButtonTapped:(id)sender
{
    NSLog(@"save button tapped");
    
    self.task.taskDescription = self.textField.text;
    
    NSMutableOrderedSet *mutableSet = self.lists.task.mutableCopy;
    [mutableSet addObject:self.task];
    self.lists.task = [[NSOrderedSet alloc] initWithOrderedSet:mutableSet];
    self.task.list = self.lists;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];


    NSLog(@"%@", self.textField.text);
    NSLog(@"%@", self.lists.task);
}

@end
