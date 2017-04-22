//
//  ViewController.m
//  arementalkingtoomuch
//
//  Created by Jean-Paul Gorman on 22/04/2017.
//  Copyright © 2017 Jean-Paul Gorman. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *notManButton;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@end

@implementation ViewController

- (IBAction)handleButtonEvent:(UIButton *)sender {
    NSLog(@"Click!!");
    // [self updateUI];
}

@end
