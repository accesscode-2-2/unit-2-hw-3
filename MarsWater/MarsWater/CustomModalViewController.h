//
//  CustomModalViewController.h
//  MarsWater
//
//  Created by Varindra Hart on 10/9/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomModalDelegate;
@interface CustomModalViewController : UIViewController

@property (nonatomic, weak) id <CustomModalDelegate> delegate;

@end

@protocol CustomModalDelegate <NSObject>

- (void)makeNewTaskWithString:(NSString *)description;


@end