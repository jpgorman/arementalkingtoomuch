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
- (void)timerTick:(NSTimer *)timer {
    
    timerElapsed = [[NSDate date] timeIntervalSinceDate:timerStarted];
    
    double seconds = fmod(timerElapsed, 60.0);
    double minutes = fmod(trunc(timerElapsed / 60.0), 60.0);
    double hours = trunc(timerElapsed / 3600.0);
    NSLog(@"Click!!  %f", timerElapsed);
    NSLog(@"Click!!  %02.0f", seconds);
    NSLog(@"Click!!  %f", minutes);
    NSLog(@"Click!!  %f", hours);
    self.dudeTimeLabel.text = [NSString stringWithFormat:@"%02.0f:%02.0f", minutes, seconds];
}

-(void) fired {
    [timer invalidate];
    timer = nil;
    timerElapsed = 0.0;
    [self startTimer];
    NSLog(@"Click!!  %f", timerElapsed);
    // react to timer event here
}

-(void) pauseTimer {
    running = NO;
    [timer invalidate];
    timer = nil;
    timerElapsed = [[NSDate date] timeIntervalSinceDate:timerStarted];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSLog(@"Click!!  %f", timerElapsed);
    // NSString *timeString = [dateFormatter stringFromDate:timerElapsed];
    // self.dudeTimeLabel.text = timeString;
}

- (IBAction)handleButtonEvent:(UIButton *)sender {
    NSLog(@"Click!!  %@", sender.currentTitle);
    if(!running) {
        [self startTimer];
    } else {
        [self pauseTimer];
    }
    // [self updateUI];
}



@end
