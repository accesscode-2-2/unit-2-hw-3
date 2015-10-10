//
//  TaskCreationDelegate.h
//  MarsWater
//
//  Created by Christian Maldonado on 10/8/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TableCreationViewController;
@class Task;

@protocol TaskCreationDelegate <NSObject>

-(void)didCreateTask:(Task *)task;

@end
