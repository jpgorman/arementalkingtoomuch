//
//  ViewController.m
//  arementalkingtoomuch
//
//  Created by Jean-Paul Gorman on 22/04/2017.
//  Copyright © 2017 Jean-Paul Gorman. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "CustomButton.h"
#include <math.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet CustomButton *manButton;
@property (weak, nonatomic) IBOutlet CustomButton *notManButton;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dudeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *notDudeTimeLabel;
@end

@implementation ViewController
@dynamic title;

NSTimer *timer;
double timerInterval = 10.0;
double timerElapsed = 0.0;
NSDate *timerStarted;
bool isRunning = NO;
NSMutableDictionary *timers;
NSString *currentTimer;

#pragma mark - initialisation
- (void)setUp
{
    timers = [NSMutableDictionary dictionary];
    [timers setValue:@(0.0) forKey: @"dudeTimer"];
    [timers setValue:@(0.0) forKey: @"noDudeTimer"];
}

- (void)setTopic:(NSString *)topic
{
    _topic = topic;
    if (self.view.window) [self setUp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUp];
}

- (void) viewDidLoad {
    self.percentageLabel.textColor = [UIColor colorWithRed:0.73 green:0.76 blue:0.75 alpha:1.0];
    self.viewTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.viewTitle.numberOfLines = 2;
    self.percentageLabel.text = [NSString stringWithFormat:@"%2.0f%s%@", 0.0, "% ", self.topic];
    self.manButton.label = self.topic;
    self.notManButton.label = [[NSArray arrayWithObjects:@"Not", self.topic, nil] componentsJoinedByString:@" "];
}

- (void)awakeFromNib
{
    [self setUp];
    [super awakeFromNib];
}
-(void) startTimer {
    timer = [NSTimer
             scheduledTimerWithTimeInterval:0.1
             target:self
             selector:@selector(timerTick:)
             userInfo:nil
             repeats:YES
            ];
    timerStarted = [NSDate date];
    isRunning = YES;
}

-(void) updateLabel {
    
    timerElapsed = [[NSDate date] timeIntervalSinceDate:timerStarted];
    
    
    NSNumber *currentTime = timers[currentTimer];
    double timePlusOffset = timerElapsed + [currentTime doubleValue];
    double seconds = fmod(timePlusOffset, 60.0);
    double minutes = fmod(trunc(timePlusOffset / 60.0), 60.0);
    double hours = trunc(timePlusOffset / 3600.0);
    
    NSString *label = hours > 0
    ? [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f", hours, minutes, seconds]
    : [NSString stringWithFormat:@"%02.0f:%02.0f", minutes, seconds];
    
    if([currentTimer isEqual: @"dudeTimer"]) {
        self.dudeTimeLabel.text = label;
    }
    
    if([currentTimer isEqual: @"notDudeTimer"]) {
        self.notDudeTimeLabel.text = label;
    }
    
    [self updatePercentage: timerElapsed];
}

- (void) updatePercentage:(double)timerElapsed {
    NSNumber *dudeTime = timers[@"dudeTimer"];
    NSNumber *notDudeTime = timers[@"notDudeTimer"];
    
    double d_time = [currentTimer isEqual: @"dudeTimer"] ? timerElapsed + [dudeTime doubleValue] : [dudeTime doubleValue];
    double l_time = [currentTimer isEqual: @"notDudeTimer"] ? timerElapsed + [notDudeTime doubleValue] : [notDudeTime doubleValue];
    
    double percentage = d_time / (d_time + l_time) * 100;
    
    NSString *format = percentage < 10 ? @"%2.0f%s%@" : @"%02.0f%s%@";
    
    self.percentageLabel.text = [NSString stringWithFormat:format, percentage, "% ", self.topic];
}

- (void)timerTick:(NSTimer *)timer {
    
    [self updateLabel];
}

-(void) pauseTimer {
    isRunning = NO;
    [timer invalidate];
    timer = nil;
    timerElapsed = [[NSDate date] timeIntervalSinceDate:timerStarted];
    
    [self updateLabel];
    [self saveTimer: timerElapsed timerName: currentTimer];
}

-(void) saveTimer:(double)timeElapsed timerName:(NSString *)timerName {
    
    NSNumber *currentTime = timers[timerName];
    double timePlusOffset = timerElapsed + [currentTime doubleValue];
    [timers setValue:@(timePlusOffset) forKey: timerName];
    
}

- (IBAction)handleButtonEvent:(CustomButton *)sender {
    
    NSLog(@"%ld", (long)sender.tag);
    NSString *nextTimer;
    CustomButton *currentActivebutton = sender.tag == 0 ? self.notManButton : self.manButton;
    
    nextTimer = sender.tag == 0 ? @"dudeTimer" : @"notDudeTimer";
    
    if(currentTimer != nextTimer && isRunning) {
        [self pauseTimer];
        isRunning = NO;
        currentActivebutton.isActive = NO;
    }
    
    currentTimer = nextTimer;
    
    if(!isRunning) {
        sender.isActive = YES;
        [self startTimer];
    } else {
        sender.isActive = NO;
        [self pauseTimer];
    }
}



@end
