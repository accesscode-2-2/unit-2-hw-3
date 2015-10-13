//
//  ListCreationTableViewController.m
//  MarsWaterCore
//
//  Created by Daniel Distant on 10/4/15.
//  Copyright © 2015 ddistant. All rights reserved.
//

#import "ListCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

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
    
}
- (IBAction)shadedButtonTapped:(UIButton *)sender {
    
    self.list.color = sender.backgroundColor;
}

- (void) setupNavigationBar {
    self.navigationItem.title = @"Create new list";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

- (void) cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) save {
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    NSLog(@"%@", self.list);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
