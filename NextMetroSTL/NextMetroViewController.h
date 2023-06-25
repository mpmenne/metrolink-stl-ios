//
//  NextMetroViewController.h
//  NextMetroSTL
//
//  Created by Mike Menne on 9/26/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class NextMetroTrain;

@interface NextMetroViewController : UIViewController<UIScrollViewDelegate>
{
    
    int count;
    NSTimer *nsTimer;
    IBOutlet UILabel *trainHeader;
    IBOutlet UILabel *trainColor;
    IBOutlet UILabel *timeUntilNextTrain;
    IBOutlet UILabel *currentStation;
    IBOutlet UILabel *stationNickName;
    IBOutlet UILabel *trainTime;
    IBOutlet UILabel *departureLabel;

}
@property(strong, nonatomic) UIColor *uiBackgroundColor;

+(NextMetroViewController*) blankView;
+(NextMetroViewController*) stationNotFoundView;
+(NextMetroViewController*) gpsNotEnabledView;
+(NextMetroViewController *) viewForNextTrain:(NSDate*)atTime;
+(NextMetroViewController *) viewForPreviousTrain:(NSDate*)atTime;

-(id) initForTrain:(NextMetroTrain*)train atStation:(NSString*) stationName;

-(void) setBackgroundColor:(UIColor*)uiColor;

-(NSDate*)nextTrainTime;


@end
