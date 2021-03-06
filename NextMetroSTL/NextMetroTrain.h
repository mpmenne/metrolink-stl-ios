//
//  NextMetroTrain.h
//  NextMetroSTL
//
//  Created by Mike Menne on 11/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NextMetroTrain : NSObject
{
    
}


- (id) initWithHeader:(NSString *)header withColor:(NSString *)color withTime:(NSDate *)time withDeparture:(NSDate*)departureTime;

- (NSString*) arrivalTime;
- (NSInteger) millisUntilTrain;

@property(nonatomic, readwrite, strong) NSDate *trainTime;
@property(nonatomic, readwrite, strong) NSDate *departureTime;
@property(nonatomic, copy) NSString *header;
@property(nonatomic, copy) NSString *color;

@end
