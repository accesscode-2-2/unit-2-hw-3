//
//  Task+CoreDataProperties.m
//  MarsWater
//
//  Created by Chris David on 10/4/15.
//  Copyright © 2015 Chris David. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

@dynamic taskDescription;
@dynamic createAt;
@dynamic doAt;
@dynamic updatedAt;
@dynamic priority;
@dynamic completedAt;
@dynamic list;

@end
