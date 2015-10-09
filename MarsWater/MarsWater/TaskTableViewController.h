//
//  TaskTableViewController.h
//  MarsWater
//
//  Created by Justine Gartner on 10/5/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@protocol TaskTableViewControllerDelegate <NSObject>

-(void)didSelectTask: (Task *)selectedTask atIndexPath: (NSIndexPath *)indexPath;

@end

@interface TaskTableViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, weak)id <TaskTableViewControllerDelegate> delegate;

@property (nonatomic) NSIndexPath *selectedTaskIndexPath;

@property (nonatomic) List *list;

@end
