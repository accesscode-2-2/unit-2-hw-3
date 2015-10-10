//
//  TaskCreationViewController.m
//  MarsWater
//
//  Created by Bereket  on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskCreationViewController.h"
//#import "AppDelegate.h"
//#import "TasksTableViewController.h"
//#import <CoreData/CoreData.h>
//#import "Task.h"


@interface TaskCreationViewController ()

@property (nonatomic) NSMutableOrderedSet *taskList;

@end

@implementation TaskCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];

    NSLog(@"Current List 2: %@", self.list);
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
    
    self.task.taskDescription = self.addTaskTextField.text;
    self.task.createdAt = [NSDate date]; // not really necessary I gues since the textLabel or detail wont show it but w/e
   
    self.taskList = self.list.task.mutableCopy;
    
    [self.taskList addObject:self.task];
    
    self.list.task = self.taskList;
    
    NSLog(@"self.list.tasks: %@",self.list.task);
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
   // [self dismiss];
    
    
    //self.task.taskDescription = self.addTaskTextField.text;
    
//    self.list.title = self.titleTextField.text;
//    self.list.createdAt = [NSDate date];
//    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    [delegate.managedObjectContext save:nil];
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([[segue identifier]isEqualToString:@"taskCreateSegue"]){
//   
//        UINavigationController *navController = segue.destinationViewController;
//        TaskCreationViewController* viewController = navController.viewControllers[0];
//        NSLog(@"passing this list: %@", self.list);
//         viewController.list = self.list;
//    }
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
