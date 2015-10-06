//
//  ItemsTableViewController.h
//  CoreDataHomeworkPrep
//
//  Created by Shena Yoshida on 10/5/15.
//  Copyright © 2015 Shena Yoshida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "ListsTableViewController.h"
#import "AppDelegate.h"

@interface ItemsTableViewController : UITableViewController

//@property (nonatomic) List *listTitle; // create property to hold title of to do list in segue
@property (nonatomic) Task *task;
@property (nonatomic) NSString *listName;
@property (nonatomic) id listColor;

@end
