//
//  NextMetroAppDelegate.m
//  NextMetroSTL
//
//  Created by Mike Menne on 9/26/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroAppDelegate.h"

#import "NextMetroViewController.h"
#import "NextMetroStationStore.h"
#import "NextMetroStation.h"
#import "NextMetroTrain.h"

@interface NextMetroAppDelegate()
{
    
}
@end

@implementation NextMetroAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    currentStationName = @"none";
    
    NextMetroViewController *blankView = [NextMetroViewController blankView];
    
    if (blankView) {
        
        
        UIPageViewController *pageViewController = (UIPageViewController *)self.window.rootViewController;
        pageViewController.dataSource = self;
        
        [pageViewController setViewControllers:@[blankView]
                                     direction:UIPageViewControllerNavigationDirectionForward
                                      animated:NO
                                    completion:NULL];
    }
    
    return YES;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(NextMetroViewController *)vc
{
    NextMetroViewController *previousView = [NextMetroViewController viewForPreviousTrain:[vc nextTrainTime]];
    // show the view if it is less than five minutes difference
    NSComparisonResult recentResult = [[previousView nextTrainTime] compare:[[NSDate date] dateByAddingTimeInterval:-180]];
    if (recentResult == NSOrderedDescending || recentResult == NSOrderedSame) {
        return previousView;
    }
    NSComparisonResult result = [[previousView nextTrainTime] compare:[NSDate date]];
    if (result == NSOrderedAscending) {
        return nil;
    }
    return previousView;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(NextMetroViewController *)vc
{
    return [NextMetroViewController viewForNextTrain:[vc nextTrainTime]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSString *closestStation = [[NextMetroStationStore defaultStore] findClosestLocation:locations.lastObject];
    if (![currentStationName isEqualToString: closestStation]) {
        [self refreshStation:[locations lastObject]];
    }
    
}

- (void)refreshStation:(CLLocation*)location
{
    [NextMetroStationStore.defaultStore updateLocation:location];
    currentStationName = NextMetroStationStore.defaultStore.currentStation.name;
    
    NextMetroViewController *newPageView = [NextMetroViewController viewForNextTrain:[NSDate date]];
    UIPageViewController *pageViewController = (UIPageViewController *)self.window.rootViewController;
    
    if (newPageView) {
        [pageViewController setViewControllers:@[newPageView]
                                     direction:UIPageViewControllerNavigationDirectionForward
                                      animated:NO
                                    completion:NULL];
    } else {
        NextMetroViewController *stationNotFoundView = [NextMetroViewController stationNotFoundView];
        [pageViewController setViewControllers:@[stationNotFoundView]
                                     direction:UIPageViewControllerNavigationDirectionForward
                                      animated:NO
                                    completion:NULL];
    }
    
}

-(void) dealloc
{
    locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"We are active!   %@", NSStringFromSelector(_cmd));
    currentStationName = nil;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
