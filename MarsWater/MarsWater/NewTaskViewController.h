//
//  NewTaskViewController.h
//  MarsWater
//
//  Created by Henna on 10/9/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "ViewController.h"


@class List; // let this view controller know that List is a valid class

@interface NewTaskViewController : ViewController

    @property (nonatomic) List *list;

@end
