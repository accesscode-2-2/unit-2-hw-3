//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Ayuna Vogel on 10/7/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "TasksTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import "CreateTaskTableViewController.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSMutableOrderedSet *tasksList;

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.navigationItem.title = @"Tasks";
    self.navigationItem.title = self.list.title;
    
    [self.tableView reloadData];
    
    self.tableView.backgroundColor = self.list.color;
    self.tableView.backgroundView.backgroundColor = self.list.color;


    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    
//    //Create an instance of NSFetchRequest with an entity name
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
//    
//    //create a sort descriptor
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
//    
//    //set the sort descriptors on the fetchRequest
//    fetchRequest.sortDescriptors = @[sort];
//    
//    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
//    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    
//    self.fetchedResultsController.delegate = self;
//    
//    [self.fetchedResultsController performFetch:nil];
//    

    
     
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    Task *task = self.list.task[indexPath.row];
    
    cell.textLabel.text = task.taskDescription;
    cell.backgroundColor = self.list.color;
    
    return cell;
    //Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    //cell.textLabel.text = task.taskDescription;
    //cell.backgroundColor = (UIColor *)task.color;
    
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    formatter.dateStyle = NSDateFormatterShortStyle;
    //    cell.detailTextLabel.text = [formatter stringFromDate:task.createdAt];
}

// NSFetchResultsController delegate method
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Task *selectedTask = self.list.task[indexPath.row];
        [self removeObjectFromCoreDataContext:selectedTask];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}


#pragma mark - Core Data method 

-(void)removeObjectFromCoreDataContext:(Task *)selectedTask {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    [context deleteObject:selectedTask];
    [context processPendingChanges];
    
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    CreateTaskTableViewController *createTaskTVC = (CreateTaskTableViewController *)([navController viewControllers][0]);
    createTaskTVC.list = self.list;
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
