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

@interface NextMetroViewController ()

@end

@implementation NextMetroViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initTimer];
    count = 6;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (count > 5) {
        NSLog(@"%@", locations);
        CLLocation *clLocation = [locations lastObject];
        NextMetroStationStore *store = [NextMetroStationStore defaultStore];
        [store updateLocation:clLocation];
        [currentStation setText: [[store currentStation] name]];
        [stationNickName setText: [[store currentStation] nickName]];
        [trainHeader setText:[[[store currentStation] nextTrain] header]];
        [timeUntilNextTrain setText:[[[store currentStation] nextTrain] timeUntilTrain]];
        count = 0;
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)initTimer
{    
    [nsTimer invalidate];
    nsTimer = nil;
    nsTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer) userInfo:nil repeats:true];
}

- (void) fireTimer
{
//    if (count > 0) {
//        count = count - 1000;
//    } else {
//        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"music_noise" ofType:@"wav"];
//        SystemSoundID soundID;
//        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
//        AudioServicesPlaySystemSound(soundID);
//    }

    count++;
    [timeUntilNextTrain setText:[[[[NextMetroStationStore defaultStore] currentStation] nextTrain] timeUntilTrain]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [locationManager setDelegate:nil];
}

@end
