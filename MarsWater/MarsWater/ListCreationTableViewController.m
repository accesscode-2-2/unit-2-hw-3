//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Henna on 10/4/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "ListCreationTableViewController.h"
#import "List.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ListCreationTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) List *list;
@end

@implementation ListCreationTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavigationBar];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    
    NSLog(@"%@", self.list);
}


- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    const CGFloat *components = CGColorGetComponents(sender.backgroundColor.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    self.list.color = [NSString stringWithFormat:@"%02lX%02lX%02lX",
                       lroundf(r * 255),
                       lroundf(g * 255),
                       lroundf(b * 255)];
    NSLog(@"%@", self.list.color);
    
}

- (void) setupNavigationBar{

//set title
    
    self.navigationItem.title = @"Create new list";
    
// set left button to cancel
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
//set right button to save
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

-(void) cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) save{
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    NSLog(@"%@", self.list);
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    self.list.title = self.titleTextField.text;
}

@end
