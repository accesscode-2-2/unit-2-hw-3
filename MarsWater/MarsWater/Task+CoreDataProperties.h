//
//  Task+CoreDataProperties.h
//  MarsWater
//
//  Created by Justine Gartner on 10/4/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *taskDescription;
@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) NSDate *dueDate;
@property (nullable, nonatomic, retain) NSDate *updatedAt;
@property (nullable, nonatomic, retain) NSNumber *priority;
@property (nullable, nonatomic, retain) NSDate *completedAt;
@property (nullable, nonatomic, retain) NSManagedObject *list;
@property (nullable, nonatomic, retain) id color;

@end

NS_ASSUME_NONNULL_END
