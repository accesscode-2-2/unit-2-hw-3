//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Jovanny Espinal on 10/4/15.
//  Copyright © 2015 Jovanny Espinal. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h"

@interface ListCreationTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic)List *list;

@end

@implementation ListCreationTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    
    NSLog(@"%@", self.list);
}

-(void)setupNavigationBar{
    //Set the title
    self.navigationController.title = @"Create New List";
    
    //Set the left bar to cancel
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    //Set the right button to save
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

-(void)save{
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    [self cancel];
    NSLog(@"%@", self.list);
    
    
}

-(void)cancel{
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)colorButtonTapped:(UIButton *)sender{
    self.list.color = sender.backgroundColor;
}

@end
