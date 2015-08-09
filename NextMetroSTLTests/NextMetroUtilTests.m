//
//  NextMetroUtilTests.m
//  NextMetroSTL
//
//  Created by Mike Menne on 8/2/15.
//  Copyright (c) 2015 com.menne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NextMetroUtil.h"

@interface NextMetroUtilTests : XCTestCase {
    NSCalendar* _calendar;
    NSDateComponents* _components;
    NSDateFormatter* _dateFormatter;
}

@end

@implementation NextMetroUtilTests



- (void)setUp {
    [super setUp];
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    _components = [_calendar components:NSUIntegerMax fromDate:[NSDate date]];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBadTimesAreNil {
    XCTAssertNil([NextMetroUtil parseDateFromString:@"junk"]);
}

- (void)testValidTimesReturnDates {
    XCTAssertNotNil([NextMetroUtil parseDateFromString:@"14:27:00"]);
}

- (void)testShouldImportWithCentralTime {
    [_components setHour:14];
    [_components setMinute:27];
    [_components setSecond:0];
    NSDate *expected = [_calendar dateFromComponents:_components];
    XCTAssertEqualObjects([_dateFormatter stringFromDate:expected], [_dateFormatter stringFromDate: [NextMetroUtil parseDateFromString:@"14:27:00" ]]);
}

- (void)testTwentyFourthHourShouldBeTheNextDay {
    XCTAssertEqualObjects(@"2015-08-10 00:19:00", [_dateFormatter stringFromDate: [NextMetroUtil parseDateFromString:@"24:19:00" ]]);
}

@end
