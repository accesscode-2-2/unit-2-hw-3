//
//  Task+CoreDataProperties.h
//  MarsWater
//
//  Created by Zoufishan Mehdi on 10/4/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *taskDescription;
@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) NSDate *dueAt;
@property (nullable, nonatomic, retain) NSDate *updatedAt;
@property (nullable, nonatomic, retain) NSNumber *priority;
@property (nullable, nonatomic, retain) NSDate *completedAt;
@property (nullable, nonatomic, retain) List *list;

@end

NS_ASSUME_NONNULL_END
