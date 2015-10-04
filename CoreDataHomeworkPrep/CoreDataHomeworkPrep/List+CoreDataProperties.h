//
//  List+CoreDataProperties.h
//  CoreDataHomeworkPrep
//
//  Created by Shena Yoshida on 10/4/15.
//  Copyright © 2015 Shena Yoshida. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface List (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) id color;
@property (nullable, nonatomic, retain) NSArray *task;

@end

NS_ASSUME_NONNULL_END
