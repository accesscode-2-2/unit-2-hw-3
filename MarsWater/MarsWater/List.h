//
//  List.h
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/7/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

NS_ASSUME_NONNULL_BEGIN

@interface List : NSManagedObject

-(NSString *)subtitleText;
@end

NS_ASSUME_NONNULL_END

#import "List+CoreDataProperties.h"
