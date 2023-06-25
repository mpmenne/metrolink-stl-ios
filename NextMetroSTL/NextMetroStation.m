//
//  NextMetroStation.m
//  NextMetroSTL
//
//  Created by Mike Menne on 11/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroStation.h"
#import "NextMetroTrain.h"
#import "NextMetroUtil.h"

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
            NSString *trainHeaderString = [self formatTrainText:columns[0]];
            NSDate *trainTime = [NextMetroUtil parseDateFromString:columns[5]];
            NSDate *departureTime = [NextMetroUtil parseDateFromString:columns[6]];
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

-(NSString*) dayOfWeekPostfix
{
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    NSString *dayOfWeek = [myFormatter stringFromDate:[NSDate date]];
    if ([dayOfWeek isEqualToString:@"Saturday"]) {
        return @"ss";
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        return @"ss";
    } else {
        return @"mf";
    }
}

- (NSString *)formatTrainText:(NSString *)trainText {
    trainText = [trainText stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    trainText = [trainText stringByReplacingOccurrencesOfString:@"BLUE LINE " withString:@""];
    trainText = [trainText stringByReplacingOccurrencesOfString:@"RED LINE " withString:@""];
    
    return trainText;
}


@end
