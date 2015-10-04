//
//  ListsCreationTableViewController.m
//  CoreDataExamples
//
//  Created by Jason Wang on 10/4/15.
//  Copyright © 2015 Jason Wang. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListsCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h"


@interface ListsCreationTableViewController ()

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@property (nonatomic) List *list;

@end

@implementation ListsCreationTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    NSLog(@"%@", self.list);
}

-(void)setupNavigationBar {
    
    //set the title
    self.navigationItem.title = @"Create New List";
    
    //set the left bar to cancel
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    //set the right button to save
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
}

-(void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save {
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [[NSDate alloc] init];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    self.list.color = sender.backgroundColor;
    
}


@end
