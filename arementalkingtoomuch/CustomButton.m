//
//  CustomButton.m
//  arementalkingtoomuch
//
//  Created by Jean-Paul Gorman on 01/05/2017.
//  Copyright © 2017 Jean-Paul Gorman. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton()
@end

@implementation CustomButton

#pragma mark - properties

- (void)setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    [self setNeedsDisplay];
}

#pragma mark - drawing
- (CGFloat)cornerRadius{ return 0.5 * self.bounds.size.width;}

- (void)drawCircleWithXoffset:(int)atOffset withBackground:(UIColor*)backgroundColor {
    
    int offset = 5;
    
    UIBezierPath *layer = [UIBezierPath
                           bezierPathWithRoundedRect:CGRectMake(offset, atOffset, self.bounds.size.width - offset, self.bounds.size.height - offset)
                           cornerRadius:[self cornerRadius]];
    [backgroundColor setFill];
    [layer fill];
}

- (void)drawRect:(CGRect)rect {
    
    // Draw shadow
    [self drawCircleWithXoffset:5 withBackground:[UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0]];
    
    // Draw button
    UIColor *backgroundColor = self.isActive
    ? [UIColor colorWithRed:0.73 green:0.76 blue:0.75 alpha:1.0]
    : [UIColor colorWithRed:0.85 green:0.89 blue:0.86 alpha:1.0];
    
    [self drawCircleWithXoffset:self.isActive ? 5 : 0 withBackground:backgroundColor];
    
}

#pragma mark - initialisation
- (void)setUp
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setUp];
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
