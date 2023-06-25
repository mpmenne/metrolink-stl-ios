//
//  NextMetroStationViewController.h
//  NextMetroSTL
//
//  Created by Mike Menne on 8/9/15.
//  Copyright (c) 2015 com.menne. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NextMetroStationCell.h"

@interface NextMetroStationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray* stationNames;

-(id) initWithStationList: (NSMutableArray*) stationNames;
@end