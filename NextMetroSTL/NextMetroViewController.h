//
//  NextMetroViewController.h
//  NextMetroSTL
//
//  Created by Mike Menne on 9/26/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NextMetroViewController : UIViewController
{
    CLLocationManager *locationManager;
    
    int count;
    NSTimer *nsTimer;
    IBOutlet UILabel *trainHeader;
    IBOutlet UILabel *timeUntilNextTrain;
    IBOutlet UILabel *currentStation;
    IBOutlet UILabel *stationNickName;

}


@end
