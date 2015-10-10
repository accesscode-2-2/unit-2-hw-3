//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Eric Sze on 10/4/15.
//  Copyright © 2015 myApps. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "ListCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h"

@interface ListCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) List *list;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    // gives us access to this class: AppDelegate
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // insertNewObject: take the entity you want by listing it as a string    // take managedObjectContext from AppDelegate
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    
    NSLog(@"%@", self.list);
}

- (void)setupNavigationBar {
    // set the title
    // set the left bar to cancel
    // set the right button to save
    
    self.navigationItem.title = @"Create new list";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    
    NSLog(@"%@", self.list);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    self.list.color = sender.backgroundColor;

}


// how to populate created task appear on previous table view controller after "save" is hit
// make selected cell present modally a new table view controller for user to add or delete tasks
// ask how to use core data to get this done, which tutorials should I follow to be able to get all of this done


@end
