//
//  TaskDetailTableViewController.m
//  MarsWater
//
//  Created by Felicia Weathers on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskDetailTableViewController.h"
#import "Task.h"
#import "TaskCreationTableViewController.h"

@interface TaskDetailTableViewController ()
<
NSFetchedResultsControllerDelegate
>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TaskDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
    
    }

- (IBAction)addButton:(id)sender {
    
    TaskCreationTableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskCreation"];
    viewController.lists = self.lists;
    [self.navigationController pushViewController: viewController animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // list entity has tasks
    return self.lists.task.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskReuseIdentifier" forIndexPath:indexPath];
    
    
    // lists has many tasks
    Task *task = self.lists.task[indexPath.row];
    
    cell.textLabel.text = task.taskDescription;
//    cell.detailTextLabel.text = task.updatedAt;
    
    return cell;
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView reloadData];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
/*    -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
        if ([[segue identifier] isEqualToString:@"addCourse"]) {
            
            //ex
            //1. to typical view controller with modal segue
            //AddCourseViewController *acvc = (AddCourseViewController *)[segue destinationViewController];
            
            //2. embed in navigation controller with modal segue
            UINavigationController *nav = [segue destinationViewController];
            AddCourseViewController *acvc = (AddCourseViewController *)[nav topViewController];
            
            acvc.delegate =self;
            
            Course *newCourse = (Course *) [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:[self managedObjectContext]];
            
            acvc.currentCourse = newCourse;
        }s the selected object to the new view controller.
 */
    
//    UINavigationController *nav = [segue destinationViewController];
//    
//    TaskCreationTableViewController *vc = (TaskCreationTableViewController *)[nav topViewController];
//    
//    vc.lists = self.lists;
//}


@end
