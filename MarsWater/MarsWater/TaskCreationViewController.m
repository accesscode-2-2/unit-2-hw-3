//
//  TaskCreationViewController.m
//  MarsWater
//
//  Created by Bereket  on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationViewController.h"

@interface TaskCreationViewController ()

@end

@implementation TaskCreationViewController

- (IBAction)AddTaskButtonTapped:(id)sender {
    
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    // Do any additional setup after loading the view.
}



- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Create new task";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    // set the right button to save
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.list.title = self.titleTextField.text;
//    self.list.createdAt = [NSDate date];
//    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    [delegate.managedObjectContext save:nil];
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
