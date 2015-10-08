//
//  List.m
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 10/7/15.
//  Copyright © 2015 Mesfin. All rights reserved.
//

#import "List.h"
#import "Task.h"

@implementation List

-(NSString *)subtitleText{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    return [dateFormatter stringFromDate:self.createdAt];
}
@end
