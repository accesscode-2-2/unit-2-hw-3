//
//  Task.h
//  MarsWater
//
//  Created by Henna on 10/4/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * taskDescription;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * doAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSDate * completedAt;
@property (nonatomic, retain) List *list;

@end
