//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Chris David on 10/4/15.
//  Copyright © 2015 Chris David. All rights reserved.
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
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    
    NSLog(@"%@", self.list);

}

- (void)setupNavigationBar {

    self.navigationItem.title = @"Create New List";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];


}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", self.list);
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    self.list.color = sender.backgroundColor;
    
}

@end
