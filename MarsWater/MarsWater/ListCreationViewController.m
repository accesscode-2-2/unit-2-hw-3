//
//  ListCreationViewController.m
//  MarsWater
//
//  Created by Fatima Zenine Villanueva on 10/9/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "List.h"
#import "ListCreationViewController.h"

@interface ListCreationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *listTextField;

@property (nonatomic) List *list;

@end

@implementation ListCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    
    self.list.color = nil;
    self.list.title = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)marsWaterColorButton:(UIButton *)sender {
    self.list.color = sender.backgroundColor;
}

- (IBAction)save:(UIBarButtonItem *)sender {
    
    self.list.title = self.listTextField.text;
    self.list.createdAt = [NSDate date];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
