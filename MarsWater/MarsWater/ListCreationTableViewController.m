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
@property (weak, nonatomic) IBOutlet UIButton *redColor;
@property (weak, nonatomic) IBOutlet UIButton *orangeColor;
@property (weak, nonatomic) IBOutlet UIButton *blueColor;
@property (weak, nonatomic) IBOutlet UIButton *lightBlueColor;
@property (nonatomic) UIImage *checkBackgroundImage;


@property (nonatomic) List *list;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.checkBackgroundImage = [UIImage imageNamed:@"check"];

    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Create new list";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    // set the right button to save
}

- (void)cancel {
    
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.managedObjectContext deleteObject:self.list];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    
    if ([self.titleTextField.text isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooops!" message:@"Please fill out the title field" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK action");
                                   }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
    self.list.title = self.titleTextField.text;
    self.list.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
}

- (IBAction)redColorSelected:(UIButton *)sender {
    
    self.list.color = sender.backgroundColor;
    
    [self.redColor setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.orangeColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.blueColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.lightBlueColor setBackgroundImage:nil forState:UIControlStateNormal];
}
 
- (IBAction)orangeColorSelected:(UIButton *)sender {
    
    self.list.color = sender.backgroundColor;
    
    [self.orangeColor setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.redColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.blueColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.lightBlueColor setBackgroundImage:nil forState:UIControlStateNormal];
}
- (IBAction)blueColorSelected:(UIButton *)sender {
    self.list.color = sender.backgroundColor;
    
    [self.blueColor setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.orangeColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.redColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.lightBlueColor setBackgroundImage:nil forState:UIControlStateNormal];
}
- (IBAction)lightBlueColorSelected:(UIButton *)sender {
    self.list.color = sender.backgroundColor;
    
    [self.lightBlueColor setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.orangeColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.blueColor setBackgroundImage:nil forState:UIControlStateNormal];
    [self.redColor setBackgroundImage:nil forState:UIControlStateNormal];
}


- (IBAction)colorButtonTapped:(UIButton *)sender {
    self.list.color = sender.backgroundColor;
}

@end
