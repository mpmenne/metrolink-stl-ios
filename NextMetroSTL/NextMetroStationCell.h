//
//  NextMetroStationCell.h
//  NextMetroSTL
//
//  Created by Mike Menne on 8/9/15.
//  Copyright (c) 2015 com.menne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextMetroStationCell : UITableViewCell
{
    
}

-(id) initWithStation: (NSString*) stationName;

-(void)show;

-(void)hide;


@end