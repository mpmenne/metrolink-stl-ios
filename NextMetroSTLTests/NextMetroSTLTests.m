//
//  NextMetroSTLTests.m
//  NextMetroSTLTests
//
//  Created by Mike Menne on 9/26/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroSTLTests.h"

@implementation NextMetroSTLTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    float originLat = 38.616686;
    float originLong = -90.278091;
    float destinationLat = 38.635838;
    float destinationLong = 38.635838;
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)38.596254 longitude:(CLLocationDegrees)-90.290651];
    CLLocation *destination = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)38.635838 longitude:(CLLocationDegrees)-90.261928];
    float distance = [origin distanceFromLocation:destination];
    
    NSLog(@"distance from %f, %f to %f, %f is %f", originLat, originLong, destinationLat, destinationLong, distance /1000 );
    
}

@end
