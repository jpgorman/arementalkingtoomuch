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
@property (weak, nonatomic) IBOutlet UILabel *dudeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *notDudeTimeLabel;
@end

@implementation ViewController

NSTimer *timer;
double timerInterval = 10.0;
double timerElapsed = 0.0;
NSDate *timerStarted;
bool running = NO;
NSMutableDictionary *timers;
NSString *currentTimer;


#pragma mark - initialisation
- (void)setUp
{
    timers = [NSMutableDictionary dictionary];
    [timers setValue:@(0.0) forKey: @"dudeTimer"];
    [timers setObject:@(0.0) forKey: @"noDudeTimer"];
}

- (void)awakeFromNib
{
    [self setUp];
    [super awakeFromNib];
}

-(void) startTimer {
    timer = [NSTimer
             scheduledTimerWithTimeInterval:1.0
             target:self
             selector:@selector(timerTick:)
             userInfo:nil
             repeats:YES
            ];
    timerStarted = [NSDate date];
    running = YES;
}

-(void) updateLabel {
    
    timerElapsed = [[NSDate date] timeIntervalSinceDate:timerStarted];
    
    NSNumber *currentTime = timers[currentTimer];
    double timePlusOffset = timerElapsed + [currentTime doubleValue];
    
    double seconds = fmod(timePlusOffset, 60.0);
    double minutes = fmod(trunc(timePlusOffset / 60.0), 60.0);
    double hours = trunc(timePlusOffset / 3600.0);
    
    NSString *label = [NSString stringWithFormat:@"%02.0f:%02.0f", minutes, seconds];
    
    if([currentTimer  isEqual: @"dudeTimer"]) {
        self.dudeTimeLabel.text = label;
    }
    
    if([currentTimer  isEqual: @"notDudeTimer"]) {
        self.notDudeTimeLabel.text = label;
    }
}

- (void)timerTick:(NSTimer *)timer {
    
    [self updateLabel];
}

-(void) pauseTimer {
    running = NO;
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

- (IBAction)handleButtonEvent:(UIButton *)sender {
    NSLog(@"Click!!  %@", sender.currentTitle);
    currentTimer = [sender.currentTitle  isEqual: @"a dude"] ? @"dudeTimer" : @"notDudeTimer";
    if(!running) {
        [self startTimer];
    } else {
        [self pauseTimer];
    }
    // [self updateUI];
}



@end
