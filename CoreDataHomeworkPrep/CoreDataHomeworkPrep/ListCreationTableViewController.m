//
//  ListCreationTableViewController.m
//  CoreDataHomeworkPrep
//
//  Created by Shena Yoshida on 10/4/15.
//  Copyright © 2015 Shena Yoshida. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h" // now we can access the core data methods that are built in

@interface ListCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) List *list;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar]; // set up navigation controls programatically
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate; // create variable that has accesss to our delegate
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext]; // alloc init list object in core data
    
    NSLog(@"%@", self.list);
}

- (void)setupNavigationBar
{
    // set the title
    self.navigationItem.title = @"Create New List";
    
    // set the left button to cancel
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    // set the right button to save
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save
{
    self.list.title = self.titleTextField.text; // set title
    self.list.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate; // set delegate
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil]; // dismiss view controller
    
    // NSLog(@"%@", self.list); // test it
}

- (IBAction)colorButtonTapped:(UIButton *)sender
{
    self.list.color = sender.backgroundColor;
}


@end
