//
//  NextMetroTrailTests.m
//  NextMetroSTL
//
//  Created by Mike Menne on 11/24/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NSDate+NSDateMock.h"
#import "NextMetroTrailTests.h"

@implementation NextMetroTrailTests

- (void)setUp
{
    [super setUp];
    
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void) testThatATrainLeavingRightNowLeavesInZeroMilliseconds
{
    SwizzleClassMethod([NSDate class], @selector(date), @selector(mockCurrentDate));
//    [NSDate setMockDate:@"2007-03-24 10:45"];
    NSLog(@"Date is: %@", [NSDate date]);
}


@end
