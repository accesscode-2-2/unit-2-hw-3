//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Justine Gartner on 10/4/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "CreateListTableViewController.h"
#import "List.h"
#import "AppDelegate.h"

@interface CreateListTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic)List *list;

@end

@implementation CreateListTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];

    
    [self setupNavigationBar];
}

-(void)setupNavigationBar{
    
    self.navigationItem.title = @"Create New List";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:224.0/255.0 green:35.0/255.0 blue:70.0/255.0 alpha:1.0];

}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    self.list.color = sender.backgroundColor;
    sender.alpha = 0.3;
}

-(void)save{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // set task's properties
    
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    
    [delegate.managedObjectContext save:nil]; // saves task's properties to the core data context, incl. color method that is outside of this method, because appdelegate and entity were initiated in the viewDidLoad method 
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@", self.list);
}


@end
