//
//  TableCreationViewController.h
//  MarsWater
//
//  Created by Christian Maldonado on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCreationDelegate.h"

@interface TableCreationViewController : UIViewController

@property (nonatomic, weak) id<TaskCreationDelegate> delegate;


@end
