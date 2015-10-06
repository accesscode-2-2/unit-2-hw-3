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

@interface ListCreationTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@property (nonatomic) List *list;
@property (nonatomic) Task *task;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

- (void)setupNavigationBar{
    self.navigationItem.title = @"Create new list";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)save{
    
    if(self.titleTextField.text){
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
        self.list.title = self.titleTextField.text;
        self.list.createdAt = [NSDate date];
    }
    if(self.taskTextField.text){
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        //Checks to see if user has comma separated tasks or just one task
        if([self.taskTextField.text rangeOfString:@","].location != NSNotFound)
        {
            NSArray *commaSeparatedTasks = [self.taskTextField.text componentsSeparatedByString:@","];
            NSMutableArray<Task *> *tasksArray = [NSMutableArray<Task *> new];
            for(NSString *taskString in commaSeparatedTasks)
            {
                self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
                self.task.taskDescription = taskString;
                self.task.createdAt = [NSDate date];
                [tasksArray addObject:self.task];
                NSLog(@"These are your tasks%@",self.task);
            }
            self.list.tasks = [NSOrderedSet orderedSetWithArray:tasksArray];
        }else
        {
            self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
            self.task.taskDescription = self.taskTextField.text;
            self.task.createdAt = [NSDate date];
            self.list.tasks =[NSOrderedSet orderedSetWithObject:self.task];
        }
        
    }
    
    NSLog(@"This are the tasks%@",self.list.tasks);
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}


- (IBAction)colorButtonTapped:(UIButton *)sender {
    self.list.color = sender.backgroundColor;
}


@end
