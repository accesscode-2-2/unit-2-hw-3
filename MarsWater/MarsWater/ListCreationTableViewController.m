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

@interface ListCreationTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *orangeButton;
@property (weak, nonatomic) IBOutlet UIButton *pinkButton;
@property (weak, nonatomic) IBOutlet UIButton *purpleButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (nonatomic) UIImage *checkBackgroundImage;


@property (nonatomic) List *list;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.checkBackgroundImage = [UIImage imageNamed:@"check"];
    self.titleTextField.delegate = self;

    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Create new list";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}



// set the right button to save

- (void)save {
    
    if ([self.titleTextField.text isEqualToString:@""]) {
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooops!" message:@"Please fill out the textfields" preferredStyle: UIAlertControllerStyleAlert];
        
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

//# pragma mark - text field delegate methods
//-(BOOL) textFieldShouldReturn {
//    
//    [self.view endEditing:YES];
//    NSLog(@"enter");
//    [self save];
//     [self.tableView reloadData];
//    
//    //    NSString * query = self.searchTextField.text;
//    
//    //    [self makeNewAPIRequestWithSearchTerm:query andLocation:textField.text callBackBlock:^{
//    //        [self.tableView reloadData];
//    //    }];
//    
//    
//    return YES;
//}



- (IBAction)orangeButtonTapped:(UIButton *)sender {
    
    self.list.color = sender.backgroundColor;
    
    [self.orangeButton setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.pinkButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.purpleButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.blueButton setBackgroundImage:nil forState:UIControlStateNormal];

}

- (IBAction)pinkButtonTapped:(UIButton *)sender {
    
    self.list.color = sender.backgroundColor;
    
    [self.pinkButton setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.orangeButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.purpleButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.blueButton setBackgroundImage:nil forState:UIControlStateNormal];
    }
- (IBAction)purpleButtonTapped:(UIButton *)sender {
    
    
    self.list.color = sender.backgroundColor;
    [self.purpleButton setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.pinkButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.orangeButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.blueButton setBackgroundImage:nil forState:UIControlStateNormal];
    
}
- (IBAction)blueButtonTapped:(UIButton *)sender {
    
    
    self.list.color = sender.backgroundColor;
    [self.blueButton setBackgroundImage:self.checkBackgroundImage forState:UIControlStateNormal];
    
    [self.pinkButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.purpleButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.orangeButton setBackgroundImage:nil forState:UIControlStateNormal];
    
}





@end
