//
//  ItemsTableViewController.m
//  CoreDataHomeworkPrep
//
//  Created by Shena Yoshida on 10/5/15.
//  Copyright © 2015 Shena Yoshida. All rights reserved.
//


#import "ItemsTableViewController.h"
#import "ItemCreationTableViewController.h"
#import <CoreData/CoreData.h>





@interface ItemsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (nonatomic) NSArray *array;

@end

@implementation ItemsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    


   // NSLog(@"%@", self.listName);
    
    
    
    [self setupNavigationBar];
    [self fetchResults];
}

- (void)setupNavigationBar
{
    // set the title
    // self.navigationItem.title = self.listName;
    
    // set the left button to cancel
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewItem)];
}

- (void)cancel
{
  [self dismissViewControllerAnimated:YES completion:nil]; // dismiss when cancel button tapped
}

- (void)createNewItem
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"CreateItem"];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

- (void)fetchResults
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


@end
