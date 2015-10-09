//
//  ListTableViewController.m
//  MarsWater
//
//  Created by Henna on 10/4/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "ListTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "List.h"
#import "TasksTableViewController.h"

@interface ListTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchResults];
    
}

- (void)fetchResults
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"List"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellIdentifier" forIndexPath:indexPath];
    List *list = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = list.title;
    cell.backgroundColor = [self colorwithHexString:list.color alpha:1];
    
    return cell;
}


//Returns UIColor from hex string
- (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
{
    unsigned int hexint = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"passList"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
        TasksTableViewController *taskTableVC = segue.destinationViewController;
        taskTableVC.list = list;
    }
}

//Delete a list
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        List *list = self.fetchedResultsController.fetchedObjects[indexPath.row];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.managedObjectContext deleteObject:list];
        [delegate.managedObjectContext save:nil];
    }
}

@end
