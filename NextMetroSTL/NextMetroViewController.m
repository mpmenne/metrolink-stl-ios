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

+(NextMetroViewController*)blankView
{
    NextMetroViewController *view = [[NextMetroViewController alloc] initWithNibName:@"NextMetroViewController" bundle:nil];
    return view;
}

+(NextMetroViewController*)viewForNextTrain:(NSDate*)atTime
{
    NextMetroTrain *nextTrain = [[[NextMetroStationStore defaultStore] currentStation] nextTrain: atTime];
    if (nextTrain == nil)
        return nil;

    NSString *stationName = [[[NextMetroStationStore defaultStore] currentStation] name];
    NextMetroViewController *controllerView = [[NextMetroViewController alloc] initForTrain:nextTrain atStation:stationName withTime:[nextTrain trainTime]];
    [controllerView.view setBackgroundColor:[NextMetroUtil colorWithHexString:@"D1EEFC"]];
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
    }
    
    [self initTimer];
    count = 6;
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
    // Dispose of any resources that can be recreated.
}




@end
