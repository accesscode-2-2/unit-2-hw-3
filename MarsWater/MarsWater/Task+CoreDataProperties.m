//
//  Task+CoreDataProperties.m
//  MarsWater
//
//  Created by Justine Gartner on 10/4/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

@dynamic taskDescription;
@dynamic createdAt;
@dynamic dueDate;
@dynamic updatedAt;
@dynamic priority;
@dynamic completedAt;
@dynamic list;
@dynamic color; 

@end
