 //
//  NextMetroViewController.m
//  NextMetroSTL
//
//  Created by Mike Menne on 9/26/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroViewController.h"
#import "AudioToolbox/AudioToolbox.h"
#import "NextMetroStationStore.h"
#import "NextMetroStation.h"
#import "NextMetroUtil.h"
#import "NextMetroTrain.h"
#import "NextMetroReminderStore.h"
#import "NextMetroBackgroundLayer.h"
#import "Math.h"

@interface NextMetroViewController ()
{
    int _millisTilTrain;
    NSDate *_nextTrainTime;
    NSString *_stationName;
    NextMetroTrain *_train;
}
@end

@implementation NextMetroViewController
@synthesize uiBackgroundColor;

+(NextMetroViewController*)blankView
{
    NextMetroViewController *controllerView = [[NextMetroViewController alloc] initForTrain:nil atStation:@"Please enable GPS to use this app" withTime:nil];
    return controllerView;
}

+(NextMetroViewController*)stationNotFoundView
{
    NextMetroViewController *controllerView = [[NextMetroViewController alloc] initForTrain:nil atStation:@"Current Station Not Found" withTime:nil];
    [controllerView setBackgroundToColor:[UIColor grayColor]];
    return controllerView;
}

+(NextMetroViewController*)gpsNotEnabledView
{
    NextMetroViewController *controllerView = [[NextMetroViewController alloc] initForTrain:nil atStation:@"Please enable GPS11 to use this app" withTime:nil];
    [controllerView setBackgroundToColor:[UIColor grayColor]];
    return controllerView;
}

+(NextMetroViewController*)viewForNextTrain:(NSDate*)atTime
{
    NextMetroStation *currentStation = [[NextMetroStationStore defaultStore] currentStation];
    if (currentStation == nil) {
        return [self stationNotFoundView];
    }
    NextMetroTrain *nextTrain = [currentStation nextTrain: atTime];
    if (nextTrain == nil)
        return nil;

    NSString *stationName = [[[NextMetroStationStore defaultStore] currentStation] name];
    NextMetroViewController *controllerView = [[NextMetroViewController alloc] initForTrain:nextTrain atStation:stationName withTime:[nextTrain trainTime]];
    
    return controllerView;
}

+(NextMetroViewController*)viewForPreviousTrain:(NSDate*)atTime
{
    NextMetroTrain *previousTrain = [[[NextMetroStationStore defaultStore] currentStation] previousTrain:atTime];
    if (previousTrain == nil)
        return nil;
    
    NSString *stationName = [[[NextMetroStationStore defaultStore] currentStation] name];
    return [[NextMetroViewController alloc] initForTrain:previousTrain atStation:stationName withTime:[previousTrain trainTime]];
}

-(NSDate*) nextTrainTime
{
    return _nextTrainTime;
}

-(id)initForTrain:(NextMetroTrain*)train atStation:(NSString *)stationName withTime:(NSDate*)time
{
    self = [super initWithNibName:@"NextMetroViewController" bundle:nil];
    _stationName = stationName;
    _train = train;
    _nextTrainTime = time;
    _millisTilTrain = [train millisUntilTrain];
    [self setUiBackgroundColor: [NextMetroUtil colorWithHexString:_train.color]];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_train) {
        [currentStation setText:@""];
        [currentStation setText:_stationName];
        [trainHeader setText:_train.header];
        [timeUntilNextTrain setText:[self formatDuration:_millisTilTrain]];
        [trainTime setText: [NSString stringWithFormat:@"departure at %@", _train.arrivalTime]];
        [self setBackgroundToColor:uiBackgroundColor];
        count = 6;
        [self initTimer];
    } else {
        [currentStation setText:_stationName];
        [self setBackgroundToColor:uiBackgroundColor];
    }

}

- (void) setBackgroundToColor:(UIColor *)uiColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    // gradient.frame = self.view.bounds;
    gradient.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 50);
    gradient.colors = [NSArray arrayWithObjects:(id)[uiColor CGColor], (id)[[UIColor blackColor]CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"Hey we just noticed that you scrolled");
}

-(IBAction)createReminder:(id)sender
{
    NSLog(@"Hey we're going to create a reminder now.");
    NextMetroReminderStore *remindersStore = [NextMetroReminderStore reminders];
    [remindersStore addEvent:[NSString stringWithFormat:@"Metrolink Reminder \r\n %@", _train.header]];
}

- (void)initTimer
{    
    [nsTimer invalidate];
    nsTimer = nil;
    nsTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer) userInfo:nil repeats:true];
}

- (void) fireTimer
{
    _millisTilTrain = _millisTilTrain - 1;
    count++;
    if (_millisTilTrain <= 0) {
        [nsTimer invalidate];
        [timeUntilNextTrain setText:@"swipe <<"];
        return;
    }
    [timeUntilNextTrain setText:[self formatDuration:_millisTilTrain]];
}

- (NSString *)formatDuration:(int)totalSeconds
{
    int absoluteSeconds = abs(totalSeconds);
    int seconds = absoluteSeconds % 60;
    int minutes = (absoluteSeconds / 60) % 60;
    int hours = (absoluteSeconds / 3600) % 24;
    
    if (totalSeconds > 0) {
        if (hours && hours >= 0) {
            return [NSString stringWithFormat:@"%d:%02d:%02d", hours, minutes, seconds];
        } else {
            return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
        }
    } else  {
        if (hours && hours > 0) {
            return [NSString stringWithFormat:@"-%d:%02d:%02d", hours, minutes, seconds];
        } else {
            return [NSString stringWithFormat:@"-%d:%02d", minutes, seconds];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Did just receive memory warning");
    // Dispose of any resources that can be recreated.
}




@end
