//
//  NextMetroStation.m
//  NextMetroSTL
//
//  Created by Mike Menne on 11/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroStation.h"
#import "NextMetroTrain.h"

@implementation NextMetroStation
@synthesize name, nickName, trains;

-(id) initWithName:(NSString *)newName withNickName:(NSString *)newNickName
{
    self = [super init];
    
    if (self) {
        [self setName:newName];
        [self setNickName:newNickName];
        [self setTrains:[self populateTrains]];
    }
    return self;
}

-(NextMetroTrain*) nextTrain:(NSDate *)time
{
    return [self findNextTrain:time];
}

-(NextMetroTrain*) previousTrain:(NSDate *)time
{
    return [self findPreviousTrain:time];
}

-(NextMetroTrain*) findNextTrain:(NSDate*)startingAt
{
    for (NextMetroTrain *train in [self trains]) {
        NSComparisonResult result = [[train trainTime] compare:startingAt];
        if (result == NSOrderedDescending && train.departureTime) {
            return train;
        }
    }
    return nil;
}

-(NextMetroTrain*) findPreviousTrain:(NSDate*)startingAt
{
    NextMetroTrain *mostRecentTrain;
    for (NextMetroTrain *train in [self trains]) {
        NSComparisonResult result = [[train trainTime] compare:startingAt];
        if (train.departureTime) {
            if (result == NSOrderedAscending || result != NSOrderedSame) {
                mostRecentTrain = train;
                continue;
            } else {
                return mostRecentTrain;
            }
        }
    }
    return nil;
}

-(NSMutableArray*) populateTrains
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDate *now = [[NSDate alloc] init];
    NSString *csvName = [NSString stringWithFormat:@"%@-%@", self.nickName, [self dayOfWeekPostfix]];
    
    NSString *schedulePath = [[NSBundle mainBundle] pathForResource:csvName ofType:@"csv"];
    NSString *scheduleContents = [NSString stringWithContentsOfFile:schedulePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSArray *scheduleLines = [[ scheduleContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    for (NSString *line in scheduleLines) {
        NSArray *columns = [line componentsSeparatedByString:@","];
        if ([columns count] > 3) {
            NSString *trainHeaderString = columns[0];
            NSDate *trainTime = [self parseDateFromString:columns[5]];
            NSDate *departureTime = [self parseDateFromString:columns[6]];
            NSString *trainColor = columns[2];
            NSLog(@"%@ %@", trainHeaderString, trainTime);
            NextMetroTrain *train = [[NextMetroTrain alloc] initWithHeader:trainHeaderString withColor:trainColor withTime:trainTime withDeparture:departureTime];
            [array addObject:train];
        }
    }
    //sort times....
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"trainTime" ascending:TRUE];
    [array sortedArrayUsingDescriptors:@[descriptor]];
    return array;
}

-(NSDate*) parseDateFromString:(NSString*)dateString
{
    if (!dateString) { return nil; }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSArray *timeSegments = [dateString componentsSeparatedByString:@":"];
    NSDateComponents *todayComponents = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    if ([timeSegments count] <3) { return nil; }
    [todayComponents setHour: [timeSegments[0] intValue]];
    [todayComponents setMinute: [timeSegments[1] intValue]];
    [todayComponents setSecond: [timeSegments[2] intValue]];
    NSDate *trainTime = [calendar dateFromComponents:todayComponents];
    return trainTime;
}

-(NSString*) dayOfWeekPostfix
{
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    NSString *dayOfWeek = [myFormatter stringFromDate:[NSDate date]];
    if ([dayOfWeek isEqualToString:@"Saturday"]) {
        return @"saturday";
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        return @"sunday";
    } else {
        return @"mf";
    }
}

@end
