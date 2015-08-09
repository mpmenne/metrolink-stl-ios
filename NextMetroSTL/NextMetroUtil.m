//
//  NextMetroUtil.m
//  NextMetroSTL
//
//  Created by Mike Menne on 12/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroUtil.h"

@implementation NextMetroUtil

+(NSDate*) parseDateFromString:(NSString*)dateString
{
    if (!dateString) { return nil; }
//    NSDateFormatter* _dateFormatter = [[NSDateFormatter alloc] init];
//    [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
//    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    
//    return [_dateFormatter dateFromString:dateString];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents *todayComponents = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    NSArray *timeSegments = [dateString componentsSeparatedByString:@":"];
    if ([timeSegments count] <3) { return nil; }
    [todayComponents setHour: [timeSegments[0] intValue]];
    [todayComponents setMinute: [timeSegments[1] intValue]];
    [todayComponents setSecond: [timeSegments[2] intValue]];
    NSDate *trainTime = [calendar dateFromComponents:todayComponents];
    return trainTime;
}

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor*)colorWithHexString:(NSString*)hex withAlpha:(float)alpha
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end
