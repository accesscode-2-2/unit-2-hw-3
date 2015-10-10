//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Bereket  on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TasksTableViewController.h"
#import "AppDelegate.h"
#import  <CoreData/CoreData.h>
#import "TaskCreationViewController.h"


@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self fetchResults];
     NSLog(@"Current List 1: %@", self.list);
    
}
- (void) fetchResults{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    // create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"taskDescription" ascending:NO];
    
    // set the sortDescriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    // NARROWS the search from the fetchRequest based on "list.title"
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"list.title == %@", self.list.title];
    
    // create a fetchedResultsController with a fetchRequest and a managedObjectContext,
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];

}
- (void)setupNavigationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
    
}
-(void)back{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.fetchedResultsController.fetchedObjects.count;
}

//dont understand this method :( Is it to adjust where the Tasks/list should be? 
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
        Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
        cell.textLabel.text = task.taskDescription;
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"TaskCreateSegue"]){
        
        UINavigationController *navController = segue.destinationViewController;
        TaskCreationViewController* viewController = navController.viewControllers[0];
        viewController.list = self.list;
        
        NSLog(@"passing this list: %@", self.list);
    }
    
}

@end
