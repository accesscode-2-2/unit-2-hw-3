//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/4/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//

#import "ListCreationTableViewController.h"
#import "List.h"
#import "Task.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "NSString+Length.h"

@interface ListCreationTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@property (nonatomic) UIColor *listColor;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Create new list";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.0/255 green:118.0/255 blue:255.0/255 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSArray *)commaSeparatedTasksFromString:(NSString *)taskString {
    
    NSArray *commaSeparatedTasks = [taskString componentsSeparatedByString:@","];
    return commaSeparatedTasks;
}

- (void)save {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSString *title = self.titleTextField.text;
    NSString *taskString = self.taskTextField.text;
    
    if([title isValid]) {
        List *list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
        if(self.listColor == nil) {
            //assigns a default color to a list if user decides not assign one.
            [list setValue:[UIColor colorWithRed:0.0/255 green:118.0/255 blue:255.0/255 alpha:1.0] forKey:@"color"];
        }
        else {
            [list setValue:self.listColor forKey:@"color"];
        }
        [list setValue:title forKey:@"title"];
        [list setValue:[NSDate date] forKey:@"createdAt"];
        
        if(taskString && taskString.length) {
            //Checks to see if user has comma separated tasks or just one task
            if([taskString rangeOfString:@","].location != NSNotFound) {
                NSArray *commaSeparatedTasks = [self commaSeparatedTasksFromString:taskString];
                NSMutableOrderedSet *mutableSet = [list mutableOrderedSetValueForKey:@"tasks"];
                for(NSString *taskString in commaSeparatedTasks){
                    Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
                    [task setValue:taskString forKey:@"taskDescription"];
                    [task setValue:[NSDate date] forKey:@"createdAt"];
                    [mutableSet addObject:task];
                    [list setValue:mutableSet forKey:@"tasks"];
                    NSLog(@"These are your taskStrings: %@",task.taskDescription);
                }
                //there's only one task
            }
            else {
                Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
                NSMutableOrderedSet *mutableSet = [list mutableOrderedSetValueForKey:@"tasks"];
                task.taskDescription = taskString;
                task.createdAt = [NSDate date];
                [mutableSet addObject:task];
                [list setValue:mutableSet forKey:@"tasks"];
            }
        }
        NSError *error = nil;
        if([list.title isValid]) {
            if([delegate.managedObjectContext save:&error]){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                if(error) {
                    NSLog(@"Unable to save list");
                    NSLog(@"%@ %@",error, error.localizedDescription);
                }
                [self alertWithMessage:@"Your to-do list could not be saved" andTitle:@"Warning/Error"];
            }
        }
        //there was no title
    }
    else {
        [self alertWithMessage:@"You need to put a title before you save" andTitle:@"Hold up"];
    }
}

#pragma mark - Alert Methods

- (void)alertWithMessage:(NSString *)message andTitle:(NSString *)title {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [controller addAction:okAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)colorButtonTapped:(UIButton *)sender
{
    self.listColor = sender.backgroundColor;
}


@end
