//
//  List.h
//  MarsWater
//
//  Created by Henna on 10/4/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface List : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) Task *task;

@end
