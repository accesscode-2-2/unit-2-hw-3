//
//  CustomTableViewCell.h
//  MarsWater
//
//  Created by Diana Elezaj on 10/10/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;



@end
