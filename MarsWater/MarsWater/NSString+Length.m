//
//  NSString+Length.m
//  MarsWater
//
//  Created by Mesfin Bekele Mekonnen on 3/17/16.
//  Copyright © 2016 Mesfin. All rights reserved.
//

#import "NSString+Length.h"

@implementation NSString (Length)

- (BOOL)isValid {
    
    if (self.length == 0) {
        return NO;
    }
    
    if (self == nil) {
        return NO;
    }
    
    if (![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]){
        return NO;
    }
    
    return YES;
}

@end
