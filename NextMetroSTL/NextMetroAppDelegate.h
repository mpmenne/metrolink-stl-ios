//
//  NextMetroAppDelegate.h
//  NextMetroSTL
//
//  Created by Mike Menne on 9/26/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NextMetroViewController;
@class CLLocationManager;

@interface NextMetroAppDelegate : UIResponder <UIApplicationDelegate, UIPageViewControllerDataSource> {
    CLLocationManager *locationManager;
    NSString *currentStationName;

}

-(IBAction)showStations:(id)sender;

@property (strong, nonatomic) UIWindow *window;

@end
