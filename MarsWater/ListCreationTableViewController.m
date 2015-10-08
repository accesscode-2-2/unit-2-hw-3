//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Michael Kavouras on 10/4/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h"

@interface ListCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) List *list;
@property (nonatomic) id color;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
        
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Create New List";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (!self.list) {
        self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    }
    
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    
    if (!self.color) {
        self.list.color = [UIColor whiteColor];
    } else {
        self.list.color = self.color;
    }
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    self.color = sender.backgroundColor;
}

@end
