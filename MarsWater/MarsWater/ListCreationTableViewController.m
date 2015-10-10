//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Varindra Hart on 10/4/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "ListCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h"
#import "Task.h"

@interface ListCreationTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (nonatomic) NSMutableOrderedSet *setOfTasks;

@property (nonatomic) List *list;

@end

@implementation ListCreationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    self.textField.delegate = self;
    self.setOfTasks = [NSMutableOrderedSet new];
    AppDelegate *delegate= [UIApplication sharedApplication].delegate;

    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save
{
    AppDelegate *delegate= [UIApplication sharedApplication].delegate;
    if ([self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Cannot Save" message:@"Missing List Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([self.taskField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length!=0) {
        Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
        [task setValue:self.taskField.text forKey:@"itemDescription"];
        self.taskField.text = @"";
        [self.setOfTasks addObject:task];
    }
    
    NSLog(@"%@",self.list);
    [self.list setValue:self.textField.text forKey:@"title"];
    
    self.list.createdAt = [NSDate date];
    NSLog(@"%@",self.list);
    
    [self.list setValue:self.setOfTasks forKey:@"task"];
    
    [delegate.managedObjectContext save:nil];
    [self cancel];
}

- (void)setupNavigationBar
{
    self.navigationItem.title = @"Create new list";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    self.list.color = [sender backgroundColor];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    
    [self.view endEditing:YES];
    return YES;
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
