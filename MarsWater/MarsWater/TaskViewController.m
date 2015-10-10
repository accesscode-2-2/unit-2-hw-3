//
//  TaskViewController.m
//  MarsWater
//
//  Created by Artur Lan on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TaskViewController.h"
#import "AppDelegate.h"

@interface TaskViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Task";
    
    self.tableView.dataSource = self;
    self.textField.delegate = self;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.task.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.list.task[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField endEditing:YES];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:self.list.managedObjectContext];
    
    task.taskDescription = textField.text;
    [self.list.task addObject:task];
    [delegate.managedObjectContext save:nil];

    textField.text = @"";
    [self.tableView reloadData];
    
    return YES;
}

@end
