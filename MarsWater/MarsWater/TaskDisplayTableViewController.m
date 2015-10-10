//
//  TaskDisplayTableViewController.m
//  MarsWater
//
//  Created by Varindra Hart on 10/9/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "TaskDisplayTableViewController.h"
#import "CustomModalViewController.h"
#import "PresentingAnimationController.h"
#import "DismissingAnimationController.h"
#import "CustomModalViewController.h"

@interface TaskDisplayTableViewController () <UIViewControllerTransitioningDelegate, CustomModalDelegate>
@property (nonatomic) NSMutableOrderedSet *taskSet;
@end

@implementation TaskDisplayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(present)];
    self.taskSet = [[NSMutableOrderedSet alloc]initWithOrderedSet:[self.list valueForKey:@"task"]];
    
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
    
    return self.taskSet.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskIdentifier" forIndexPath:indexPath];
    
    Task *task = self.taskSet[indexPath.row];
    
    cell.textLabel.text = [task valueForKey:@"itemDescription"];
    // Configure the cell...
    
    return cell;
}

- (void)present{
    CustomModalViewController *modalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomModal"];
    modalVC.delegate = self;
//    modalVC.transitioningDelegate = self;
//    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentingAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissingAnimationController alloc] init];
}

- (void)makeNewTaskWithString:(NSString *)description{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    Task *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    [newTask setValue:description forKey:@"itemDescription"];
    [self.taskSet addObject:newTask];
    [self.tableView reloadData];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [self.list setValue:self.taskSet forKey:@"task"];
    [delegate.managedObjectContext save:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        Task *deleteTask = self.taskSet[indexPath.row];
        [delegate.managedObjectContext deleteObject:deleteTask];
        [self.taskSet removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
