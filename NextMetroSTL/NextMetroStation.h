//
//  NextMetroStation.h
//  NextMetroSTL
//
//  Created by Mike Menne on 11/11/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NextMetroTrain.h"

@interface NextMetroStation : NSObject
{
    
}

-(id) initWithName: (NSString *)name withNickName:(NSString*)nickName;

-(NextMetroTrain*) nextTrain:(NSDate*)time;
-(NextMetroTrain*) previousTrain:(NSDate*)time;


@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, strong) NSMutableArray* trains;

@end
