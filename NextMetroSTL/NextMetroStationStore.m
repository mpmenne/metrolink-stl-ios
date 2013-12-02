//
//  NextMetroStationStore.m
//  NextMetroSTL
//
//  Created by Mike Menne on 11/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroStationStore.h"
#import "NextMetroStation.h"
#import "NextMetroTrain.h"

@implementation NextMetroStationStore

+ (NextMetroStationStore *) defaultStore
{
    static NextMetroStationStore *store = nil;
    if (!store)
        store = [[super allocWithZone:nil] init];
    return store;
}

-(NSString *) findClosestLocation: (CLLocation*)location
{
    NSString *stationsPath = [[NSBundle mainBundle] pathForResource:@"stations" ofType:@"csv"];
    NSString *stationsContents = [NSString stringWithContentsOfFile:stationsPath encoding:NSUTF8StringEncoding error:NULL];
    NSArray *stationsLines = [[ stationsContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    float closestDistance = 1000000000;   // no station will be this far away :-)
    NSString *closestStationName = @"Current station not found";
    NSString *stationNickNameString = @"";
    for (NSString *stationLine in stationsLines) {
        NSString *stationName = [stationLine componentsSeparatedByString: @","][5];
        NSString *stationLat = [stationLine componentsSeparatedByString: @","][0];
        NSString *stationLong = [stationLine componentsSeparatedByString: @","][2];
        CLLocation *stationLocation = [[CLLocation alloc] initWithLatitude:[stationLat doubleValue] longitude:[stationLong doubleValue]];
        float distance = [self kilometresBetweenPlace1:location andPlace2:stationLocation];
        if (distance < closestDistance) {
            closestDistance = distance;
            closestStationName = [stationName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }
    }
    
    return closestStationName;
}

- (void) updateLocation:(CLLocation *)location
{
    NextMetroStation *closestStation = [self findClosestStation:location];
    [stations addObject:closestStation];
    [self setCurrentStation:closestStation];
}

- (NextMetroStation*) theCurrentStation
{
    return [self currentStation];
}


-(NextMetroStation *)findClosestStation:(CLLocation*) currentLocation
{
    NSString *stationsPath = [[NSBundle mainBundle] pathForResource:@"stations" ofType:@"csv"];
    NSString *stationsContents = [NSString stringWithContentsOfFile:stationsPath encoding:NSUTF8StringEncoding error:NULL];
    NSArray *stationsLines = [[ stationsContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    float closestDistance = 1000000000;   // no station will be this far away :-)
    NSString *closestStationName = @"Current station not found";
    NSString *stationNickNameString = @"";
    for (NSString *stationLine in stationsLines) {
        NSString *stationName = [stationLine componentsSeparatedByString: @","][5];
        NSString *stationLat = [stationLine componentsSeparatedByString: @","][0];
        NSString *stationLong = [stationLine componentsSeparatedByString: @","][2];
        NSLog(@"  %f   ...  %f", [stationLat doubleValue], [stationLong doubleValue]);
        CLLocation *stationLocation = [[CLLocation alloc] initWithLatitude:[stationLat doubleValue] longitude:[stationLong doubleValue]];
        float distance = [self kilometresBetweenPlace1:currentLocation andPlace2:stationLocation];
        //        NSLog(@"station %@ is %@ kilometers away", stationName, [NSString stringWithFormat:@"%f", distance / 1000]);
        if (distance < closestDistance) {
            closestDistance = distance;
            closestStationName = [stationName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            stationNickNameString = [stationLine componentsSeparatedByString: @","][7];
        }
    }
    
    NextMetroStation *station = [[NextMetroStation alloc] initWithName:closestStationName withNickName:[stationNickNameString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return station;
}

-(float)kilometresBetweenPlace1:(CLLocation*) current andPlace2:(CLLocation*) other
{
    CLLocationDistance dist = [current distanceFromLocation:other];
    NSString *strDistance = [NSString stringWithFormat:@"%.2f", dist];
    return [strDistance floatValue];
}


@end
