//
//  Task+CoreDataProperties.m
//  MarsWater
//
//  Created by Jamaal Sedayao on 10/4/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

@dynamic taskDescription;
@dynamic dueAt;
@dynamic updatedAt;
@dynamic priority;
@dynamic createdAt;
@dynamic completedAt;
@dynamic list;

@end
