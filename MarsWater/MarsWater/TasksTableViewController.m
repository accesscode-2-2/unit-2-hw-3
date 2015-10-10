//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Diana Elezaj on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//
#import <CoreData/CoreData.h>

#import "TasksTableViewController.h"
#import "Task.h"
#import "TaskCreationTableViewController.h"
#import "CustomTableViewCell.h"
#import "AppDelegate.h"


@interface TasksTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic) NSSortDescriptor *sort;
@property (nonatomic) Task *task;
@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.list.title;

    [self sorting];
    
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"will appear");
    
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
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    self.task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    cell.titleLabel.text =  _task.taskDescription ;
    
    
    NSDateFormatter *createdDateFormatter = [[NSDateFormatter alloc] init];
    [createdDateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    cell.createdAtLabel.text = [NSString stringWithFormat:@"Created at: %@",[createdDateFormatter stringFromDate:_task.createdAt] ];
    
    NSDateFormatter *dueAtDateFormatter = [[NSDateFormatter alloc] init];
    [dueAtDateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    cell.dueAtLabel.text = [NSString stringWithFormat:@"Due at: %@",[dueAtDateFormatter stringFromDate:_task.dueAt] ];
    
    cell.priorityLabel.text = [NSString stringWithFormat:@"Priority: %@",_task.priority];;
    

    NSLog(@"priority %@", _task.priority);
    
    return cell;
}


- (IBAction)segmentSelected:(UISegmentedControl *)sender {
     NSLog(@"phuuu");

    [self sorting];
    
    [self.tableView reloadData];
}

-(void) sorting {
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // 1) create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    
    // 2) create a sort descriptor
    
    if (self.segmentedControl.selectedSegmentIndex == 0)  {

    self.sort = [NSSortDescriptor sortDescriptorWithKey:@"taskDescription" ascending:YES];
    
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1)  {
        
        self.sort = [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:NO];
        
    }
    else
        self.sort = [NSSortDescriptor sortDescriptorWithKey:@"dueAt" ascending:YES];
        
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"list.title = %@", self.list.title];
    
    // 3) set the sortDescriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[self.sort];
    fetchRequest.predicate = predicate;
    
    // 4) create a fetchedResultsController with a fetchRequest and a managedObjectContext,
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}






-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UINavigationController *navController = segue.destinationViewController;
    
    TaskCreationTableViewController *taskCTVC = (TaskCreationTableViewController *)([navController viewControllers][0]);
    
    
   taskCTVC.list = self.list;
     }

@end
