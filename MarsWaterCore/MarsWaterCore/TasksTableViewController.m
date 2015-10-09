//
//  TasksTableViewController.m
//  MarsWaterCore
//
//  Created by Daniel Distant on 10/6/15.
//  Copyright © 2015 ddistant. All rights reserved.
//

#import "TasksTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import <CoreData/CoreData.h>
#import "TaskCreationTableViewController.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"doAt" ascending:YES];
    
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}
- (IBAction)addButtonTapped:(id)sender {
    TaskCreationTableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskCreation"];
    viewController.list = self.list;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.list.task.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
        
    Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    if (task != nil) {
        
        cell.textLabel.text = task.taskDescription;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Do at: %@", task.doAt];
        
        if ([task.priority isEqualToNumber: @0] ) {
            cell.backgroundColor =  [UIColor colorWithRed:225/255.0 green:215/255.0 blue:243/255.0 alpha:1];
        } else if ([task.priority isEqualToNumber: @1] ) {
            cell.backgroundColor = [UIColor colorWithRed:198/255.0 green:192/255.0 blue:253/255.0 alpha:1];
        } else if ([task.priority isEqualToNumber: @2] ) {
            cell.backgroundColor = [UIColor colorWithRed:127/255.0 green:15/255.0 blue:126/255.0 alpha:1];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
        
        if (task.completedAt != nil) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.backgroundColor = [UIColor redColor];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
    }
    
    return cell;
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}



@end
