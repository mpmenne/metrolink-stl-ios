//
//  NextMetroStationCell.m
//  NextMetroSTL
//
//  Created by Mike Menne on 8/9/15.
//  Copyright (c) 2015 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NextMetroStationCell: UITableViewCell

@end

@implementation NextMetroStationCell

-(id) initWithStation: (NSString*) stationName {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NextMetroStationCell"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.1];
    self.textLabel.text = stationName;
    self.textLabel.font = [UIFont fontWithName:@"Helvetica-Thin" size:18.0f];

    return self;
}


@end
