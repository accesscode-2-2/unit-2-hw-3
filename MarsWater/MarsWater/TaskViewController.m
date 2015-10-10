//
//  TaskViewController.m
//  MarsWater
//
//  Created by Jackie Meggesto on 10/7/15.
//  Copyright © 2015 Jackie Meggesto. All rights reserved.
//

#import "TaskViewController.h"
#import "AppDelegate.h"

@interface TaskViewController () <UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) NSMutableOrderedSet* taskSet;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    
     [super viewDidLoad];
    self.tableView.dataSource = self;
    self.textField.delegate = self;
    self.taskSet = [[NSMutableOrderedSet alloc]init];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.list.task.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    
    Task* task = self.list.task[indexPath.row];
    cell.textLabel.text = task.taskDescription;
    
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField endEditing:YES];
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
<<<<<<< HEAD
    
     Task* task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
    
    task.taskDescription = textField.text;
    
    task.createdAt = [NSDate date];
    
     self.taskSet = self.list.task.mutableCopy;
    
     [self.taskSet addObject:task];
    
    self.list.task = self.taskSet;
   
=======
     Task* task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:self.list.managedObjectContext];
    
    
    task.taskDescription = textField.text;
   
    [self.list.task addObject:task];
    NSLog(@"%ld", self.list.task.count);
>>>>>>> 4d888eab090242ebc30bbf045466aa9db7f30ab4
    
    [delegate.managedObjectContext save:nil];
    [self.tableView reloadData];
    
    return YES;
}

@end
