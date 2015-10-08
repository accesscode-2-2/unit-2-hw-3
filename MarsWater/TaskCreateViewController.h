//
//  TaskCreateViewController.h
//  MarsWater
//
//  Created by Shena Yoshida on 10/7/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@class List; // let this view controller know that List is a valid class

@interface TaskCreateViewController : UIViewController

@property (nonatomic) List *list;

@end
