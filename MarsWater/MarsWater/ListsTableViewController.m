//
//  ListsTableViewController.m
//  MarsWater
//
//  Created by Michael Kavouras on 10/4/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListsTableViewController.h"
#import "TasksTableViewController.h"
#import "AppDelegate.h"
#import "List.h"

@interface ListsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic) NSSortDescriptor *sort;
@property (nonatomic) List *list;

@end

@implementation ListsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sorting];
    [self.tableView reloadData];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.752 green:0.098 blue:0 alpha:1];

}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sorting];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCellIdentifier" forIndexPath:indexPath];
    
    List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.backgroundColor = (UIColor *)list.color;
    cell.textLabel.text = list.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSDateFormatter *createdDateFormatter = [[NSDateFormatter alloc] init];
    [createdDateFormatter setDateFormat:@"yyyy-MM-dd    HH:mm:ss"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Created at: %@",[createdDateFormatter stringFromDate:list.createdAt ]];

    return cell;
}


- (IBAction)segmentedControlChanged:(UISegmentedControl *)sender {
    [self sorting];
    [self.tableView reloadData];
}

-(void) sorting {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    if (self.segmentedControl.selectedSegmentIndex == 0)  {
        self.sort = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    }
    else
        self.sort = [[NSSortDescriptor alloc] initWithKey:@"color" ascending:NO];
    
    fetchRequest.sortDescriptors = @[self.sort];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
   
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"taskSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        TasksTableViewController *vc = segue.destinationViewController;
        
        vc.list = self.fetchedResultsController.fetchedObjects[indexPath.row];
    }
}


//delegate method that allows for editing when the edit button is clicked

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
//        delegate.managedObjectContext = [self.fetchedResultsController managedObjectContext];
        
//        [delegate.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        
         [self.tableView reloadData];
    }
    
    
    
}



@end

