//
//  CustomModalViewController.m
//  MarsWater
//
//  Created by Varindra Hart on 10/9/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "CustomModalViewController.h"
#import "pop/POP.h"

@interface CustomModalViewController ()
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;


@end

@implementation CustomModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.warningLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButtonTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)doneButtonTapped:(UIButton *)sender {
    
    if ([self.taskTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        
        self.warningLabel.hidden = NO;
        
        POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        
        shake.springBounciness = 20;
        shake.velocity = @(1000);
        
        [self.taskTextField.layer pop_addAnimation:shake forKey:@"shakePassword"];
        
        return;
    }
    
    [self.delegate makeNewTaskWithString:self.taskTextField.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
