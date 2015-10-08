//
//  List+CoreDataProperties.h
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/7/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface List (CoreDataProperties)

@property (nullable, nonatomic, retain) id color;
@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSOrderedSet<Task *> *tasks;

@end

@interface List (CoreDataGeneratedAccessors)

- (void)insertObject:(Task *)value inTasksAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTasksAtIndex:(NSUInteger)idx;
- (void)insertTasks:(NSArray<Task *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTasksAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTasksAtIndex:(NSUInteger)idx withObject:(Task *)value;
- (void)replaceTasksAtIndexes:(NSIndexSet *)indexes withTasks:(NSArray<Task *> *)values;
- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSOrderedSet<Task *> *)values;
- (void)removeTasks:(NSOrderedSet<Task *> *)values;

@end

NS_ASSUME_NONNULL_END
