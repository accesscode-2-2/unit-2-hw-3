//
//  Task+CoreDataProperties.m
//  MarsWater
//
//  Created by Eric Sze on 10/4/15.
//  Copyright © 2015 myApps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

@dynamic taskDescription;
@dynamic createdAt;
@dynamic dueAt;
@dynamic updateAt;
@dynamic priority;
@dynamic completedAt;
@dynamic list;

@end
