//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Jamaal Sedayao on 10/5/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TasksTableViewController.h"
#import "TaskCreateTableViewController.h"
#import <CoreData/CoreData.h>
#import "List.h"

#define numberOfStaticCells 1

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TasksTableViewController

- (void) setupNavBar{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewTask)];
    self.navigationItem.title = @"Tasks";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self fetchResults];
    
}
- (void) viewDidAppear:(BOOL)animated{
    [self fetchResults];
    
    [self.tableView reloadData];
    
 //   NSLog(@"%@",self.fetchedResultsController.fetchedObjects);
}

- (void) fetchResults {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    //1.create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Task"];
    
    //2. create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //3. set the sortdescriptors on the fetch request
    fetchRequest.sortDescriptors = @[sort];
    
    //4. create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
//    [self.tableView reloadData];
}

- (void)createNewTask{
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////    TaskCreateTableViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"TaskCreateID"];
////    [self presentViewController:viewController animated:YES completion:nil];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationID"];
//    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count + numberOfStaticCells;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.row < numberOfStaticCells) {
       
    cell = [tableView dequeueReusableCellWithIdentifier:@"StaticCellIdentifier" forIndexPath:indexPath];
        
        cell.textLabel.text = self.listName;
        cell.backgroundColor = (UIColor *)self.listColor;
        
        return cell;
    
    } else {
   
        cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicCellIdentifier" forIndexPath:indexPath];
        
        Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row - numberOfStaticCells];
       
//        NSString *string = [self.array objectAtIndex:indexPath.row - numberOfStaticCells];
//        
//        NSLog(@"%@",string);
        
        cell.textLabel.text = task.taskDescription;
        
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < numberOfStaticCells) {
        return 60;
    } else {
        return 44;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([[segue identifier]isEqualToString:@"taskCreateSegue"]){
        TaskCreateTableViewController *viewController = segue.destinationViewController;
        viewController.list = self.list;
    }
    
}


@end
