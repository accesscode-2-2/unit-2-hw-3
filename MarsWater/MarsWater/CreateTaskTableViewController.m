//
//  CreateTaskTableViewController.m
//  MarsWater
//
//  Created by Ayuna Vogel on 10/8/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//
#import <CoreData/CoreData.h>

#import "CreateTaskTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface CreateTaskTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (nonatomic) Task *task;

@property (nonatomic) NSMutableOrderedSet *tasksInList;


@end

@implementation CreateTaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
    [self setupNavigationBar];

    self.tasksInList = self.list.task.mutableCopy;
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupNavigationBar{
    
    self.navigationItem.title = @"Create New Task";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:224.0/255.0 green:35.0/255.0 blue:70.0/255.0 alpha:1.0];

}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    self.task.color = sender.backgroundColor;
    sender.alpha = 0.3;
}


-(void)save{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
 
    self.task.taskDescription = self.titleTextField.text;

    if (self.task.createdAt == nil) {
        
        self.task.createdAt = [NSDate date];
        
    }else {
        
        self.task.updatedAt = [NSDate date];
    }

    
    self.task.list = self.list;
    
    [delegate.managedObjectContext save:nil]; // nil = No Error, Save with no NSError parameter
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@", self.task);
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
