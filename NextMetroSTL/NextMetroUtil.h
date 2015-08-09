//
//  NextMetroUtil.h
//  NextMetroSTL
//
//  Created by Mike Menne on 12/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NextMetroUtil : NSObject

+(NSDate*) parseDateFromString:(NSString*)dateString;

+ (UIColor*) colorWithHexString:(NSString*)hex;

+ (UIColor*) colorWithHexString:(NSString*)hex withAlpha:(float)alpha;

@end
