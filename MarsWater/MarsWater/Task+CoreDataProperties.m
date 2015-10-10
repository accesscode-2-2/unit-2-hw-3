//
//  Task+CoreDataProperties.m
//  MarsWater
//
//  Created by Z on 10/10/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

@dynamic completedAt;
@dynamic createdAt;
@dynamic dueAt;
@dynamic priority;
@dynamic taskDescription;
@dynamic updatedAt;
@dynamic list;

@end
