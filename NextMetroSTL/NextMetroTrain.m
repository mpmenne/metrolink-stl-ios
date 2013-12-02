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

-(NSString*) arrivalTime
{
    return [self formatTime:[self trainTime]];
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
    
    return [[calendar components:(NSSecondCalendarUnit) fromDate:now toDate:laterDate options:0] second];
}

- (NSString *)formatTime:(NSDate*)date
{
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"hh:mm a"];
    return [dformat stringFromDate:date];
}

@end
