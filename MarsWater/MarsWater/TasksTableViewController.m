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
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.title = @"Tasks";
}
- (void) cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self fetchResults];
    
}
- (void) viewDidAppear:(BOOL)animated{
    [self fetchResults];
    
    [self.tableView reloadData];
    
}

- (void) fetchResults {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Task"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"taskDescription" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"list.title == %@", self.list.title];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    NSLog(@"Fetched Results: %@", self.fetchedResultsController.fetchedObjects);
    
    [self.tableView reloadData];
    
}

//- (void) fetchResults {
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    
//    //1.create an instance of NSFetchRequest with an entity name
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"List"];
//    
//    //[fetchRequest valueForKey:@"task"];
//    
////    NSLog(@"fetch request: %@",fetchRequest);
//    
//    //2. create a sort descriptor
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
//    
////    NSPredicate *taskPredicate = [NSPredicate predicateWithFormat:@"task == %@", self.task];
////    
////    [fetchRequest setPredicate:taskPredicate];
//    
//    //3. set the sortdescriptors on the fetch request
//    fetchRequest.sortDescriptors = @[sort];
//    
//    //4. create a fetchedResultsController with a fetchRequest and a managedObjectContext
//    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    
//    self.fetchedResultsController.delegate = self;
//    
//    [self.fetchedResultsController performFetch:nil];
//    
//    
//    NSArray *arrayOfLists = self.fetchedResultsController.fetchedObjects;
//    NSLog(@"Array Of Lists: %@",arrayOfLists);
//    
//    NSLog(@"This List: %@",self.list);
//    
//   // for arrayOfLists
//    
//    for (List *list in arrayOfLists) {
//        if (self.list == list){
//            self.list = list;
//            NSLog(@"Extracted List: %@",list);
//        }
//}
//    
//    for (List *task in [self.list valueForKey:@"task"]) {
//        NSLog(@"name = %@", [Task valueForKey:@"taskDescription"]);
//    }
//    
//   // NSLog(@"Task Array: %@",self.list.task);
//   
////    NSOrderedSet *task = self.list.task;
////
////    NSLog(@"TASK ORDERED SET: %@",task);
//    
//    
////    NSLog(@"*********");
////    NSLog(@"FETCHED RESULTS: %@",self.fetchedResultsController.fetchedObjects);
////    NSLog(@"*********");
//    
//    //NSLog(@"THIS LIST: %@", self.list);
//    
//    [self.tableView reloadData];
//}

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
        
        cell.textLabel.text = task.taskDescription;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Due Date:%@",task.dueAt];
        
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
        NSLog(@"passing this list: %@", self.list);
    }
    
}


@end
