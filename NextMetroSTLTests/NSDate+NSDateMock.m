//
//  NSDate+NSDateMock.m
//  NextMetroSTL
//
//  Created by Mike Menne on 11/24/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NSDate+NSDateMock.h"

@implementation NSDate (NSDateMock)

static NSDate *_mockDate;

+(NSDate *)mockCurrentDate
{
    return _mockDate;
}

+(void)setMockDate:(NSString *)mockDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    _mockDate = [dateFormatter dateFromString: mockDate];
}

@end
