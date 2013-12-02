//
//  NSDate+NSDateMock.h
//  NextMetroSTL
//
//  Created by Mike Menne on 11/24/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate_NSDateMock : NSObject


+(void)setMockDate:(NSString *)mockDate;
+(NSDate *) mockCurrentDate;


@end
