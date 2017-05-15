//
//  CustomTextField.m
//  arementalkingtoomuch
//
//  Created by Jean-Paul Gorman on 14/05/2017.
//  Copyright © 2017 Jean-Paul Gorman. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField()
@end

@implementation CustomTextField


- (void)setLabel:(NSString *)label
{
    _label = label;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    self.font = [UIFont systemFontOfSize:15];
    self.placeholder = self.label;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:0.85 green:0.89 blue:0.86 alpha:1.0].CGColor;
    [self.layer addSublayer:bottomBorder];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
