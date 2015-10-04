//
//  List+CoreDataProperties.h
//  MarsWater
//
//  Created by Zoufishan Mehdi on 10/4/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface List (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) NSString *color;
@property (nullable, nonatomic, retain) NSOrderedSet<Task *> *task;

@end

@interface List (CoreDataGeneratedAccessors)

- (void)insertObject:(Task *)value inTaskAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTaskAtIndex:(NSUInteger)idx;
- (void)insertTask:(NSArray<Task *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTaskAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTaskAtIndex:(NSUInteger)idx withObject:(Task *)value;
- (void)replaceTaskAtIndexes:(NSIndexSet *)indexes withTask:(NSArray<Task *> *)values;
- (void)addTaskObject:(Task *)value;
- (void)removeTaskObject:(Task *)value;
- (void)addTask:(NSOrderedSet<Task *> *)values;
- (void)removeTask:(NSOrderedSet<Task *> *)values;

@end

NS_ASSUME_NONNULL_END
