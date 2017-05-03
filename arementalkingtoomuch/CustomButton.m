//
//  CustomButton.m
//  arementalkingtoomuch
//
//  Created by Jean-Paul Gorman on 01/05/2017.
//  Copyright © 2017 Jean-Paul Gorman. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton()
@property (nonatomic, weak) UILabel *buttonLabel;
@end

static const int MARGIN = 7;

@implementation CustomButton

#pragma mark - properties

- (void)setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    [self setNeedsDisplay];
}

- (void)setLabel:(NSString *)label
{
    _label = label;
    [self setNeedsDisplay];
}

#pragma mark - drawing
- (CGFloat)cornerRadius{ return 0.5 * self.bounds.size.width;}

- (void)drawCircleWithYoffset:(int)yOffset withBackground:(UIColor*)backgroundColor {
    
    UIBezierPath *layer = [UIBezierPath
                           bezierPathWithRoundedRect:CGRectMake(MARGIN, yOffset, self.bounds.size.width - MARGIN, self.bounds.size.height - MARGIN)
                           cornerRadius:[self cornerRadius]];
    [backgroundColor setFill];
    [layer fill];
}

- (void)drawRect:(CGRect)rect {
    
    // Draw shadow
    [self drawCircleWithYoffset:7 withBackground:[UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0]];
    
    // Draw button
    UIColor *backgroundColor = self.isActive
    ? [UIColor colorWithRed:0.73 green:0.76 blue:0.75 alpha:1.0]
    : [UIColor colorWithRed:0.85 green:0.89 blue:0.86 alpha:1.0];
    
    [self drawCircleWithYoffset:self.isActive ? 5 : 0 withBackground:backgroundColor];
    
    // Remove any existing buttonLabel
    while ((self.buttonLabel = [[self subviews] lastObject]) != nil)
        [self.buttonLabel removeFromSuperview];
    
    // Add new buttonLabel
    UILabel *label = [self drawLabel:self.label];
    self.buttonLabel = label;
    [self addSubview:self.buttonLabel];
    
}

- (UILabel*)drawLabel:(NSString*)title {
    
    int yOffset = self.isActive ? 5 : 0;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - MARGIN, self.bounds.size.height - MARGIN)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName: @"Futura" size: 16.0f]];
    [label setText:title];
    [label setCenter:CGPointMake((self.bounds.size.width / 2) + MARGIN / 2, (self.bounds.size.height / 2 + yOffset))];
    return label;
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
