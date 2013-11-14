//
//  NextMetroTrain.m
//  NextMetroSTL
//
//  Created by Mike Menne on 11/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroTrain.h"

@implementation NextMetroTrain

@synthesize trainTime, header, color;

-(id) initWithHeader:(NSString *)newHeader withColor:(NSString *)newColor withTime:(NSDate *)newTime
{
    self = [super init];
    if (self) {
        [self setHeader:newHeader];
        [self setColor:newColor];
        [self setTrainTime:newTime];
    }
    return self;
}

-(NSString*) timeUntilTrain
{
    return [self timeFormatted:[self calculateTimeUntilNextTrain]];
}

-(NSInteger) millisUntilTrain
{
    return [self calculateTimeUntilNextTrain];
}

-(NSInteger) calculateTimeUntilNextTrain
{
    NSDate *now = [[NSDate alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *laterDate = [self trainTime];
    
    return [[calendar components:(NSHourCalendarUnit | NSSecondCalendarUnit) fromDate:now toDate:laterDate options:0] second];
}

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

@end
