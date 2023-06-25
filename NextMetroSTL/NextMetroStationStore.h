//
//  NextMetroStationStore.h
//  NextMetroSTL
//
//  Created by Mike Menne on 11/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class NextMetroStation;

@interface NextMetroStationStore : NSObject
{
    NSMutableArray *stations;
}

+ (NextMetroStationStore *) defaultStore;
- (NSArray *) stationList;
- (NSMutableArray *) stationOptions;
- (NSString*) findClosestLocation:(CLLocation *)location;
- (void) updateLocation:(CLLocation *)location;
- (NextMetroStation*) theCurrentStation;

@property(nonatomic, strong) NextMetroStation *currentStation;

@end
