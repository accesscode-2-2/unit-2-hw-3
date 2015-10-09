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
#import <QuartzCore/QuartzCore.h>

@interface ListCreationTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) List *list;
@property (nonatomic) NSString *priorityColor;
@property (weak, nonatomic) IBOutlet UIButton *orangebtn;
@property (nonatomic, weak) UIButton *lastSelectedButton;
@end

@implementation ListCreationTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavigationBar];

    [self.orangebtn.layer setBorderWidth:3.0];
    [self.orangebtn.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [self setLastSelectedButton:self.orangebtn];
    
}


- (IBAction)colorButtonTapped:(UIButton *)sender {
    if ([self.lastSelectedButton isEqual:sender]) {
        // Don't need to do anything in this case because the button is already selected
        return;
    }
    [self.lastSelectedButton.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [sender.layer setBorderWidth:3.0];
    [sender.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    
    [self setLastSelectedButton:sender];
    
    const CGFloat *components = CGColorGetComponents(sender.backgroundColor.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    self.priorityColor = [NSString stringWithFormat:@"%02lX%02lX%02lX",
                       lroundf(r * 255),
                       lroundf(g * 255),
                       lroundf(b * 255)];
    
}

- (void) setupNavigationBar{
    
    self.navigationItem.title = @"Make A New List!";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}

-(void) cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) save{
    if (self.titleTextField.text.length != 0) {

        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
        self.list.title = self.titleTextField.text;
        self.list.createdAt = [NSDate date];
        
        if (!self.priorityColor) {
            self.priorityColor= @"FF6600";
        }
        self.list.color = self.priorityColor;
        
        [delegate.managedObjectContext save:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"💁" message:@"Please enter a list name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

@end
