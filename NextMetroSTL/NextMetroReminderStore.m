//
//  NextMetroReminderStore.m
//  NextMetroSTL
//
//  Created by Mike Menne on 11/25/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import "NextMetroReminderStore.h"
#import "EventKit/EKEventStore.h"
#import "Foundation/Foundation.h"

@interface NextMetroReminderStore()
{
    EKEventStore *_eventStore;
}
@end

@implementation NextMetroReminderStore

+(NextMetroReminderStore*) reminders
{
    static NextMetroReminderStore *reminders = nil;
    if (!reminders) {
        reminders = [[super alloc] initWithEventStore:[[EKEventStore alloc] init]];
    };
    return reminders;
}

-(id) initWithEventStore:(EKEventStore *)eventStore
{
    self = [super init];
    if (self) {
        _eventStore = eventStore;
    }
    return self;
}

-(void) addEvent:(NSString*)eventName
{
    
    [_eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        if (granted){
        EKReminder *reminder = [EKReminder reminderWithEventStore:_eventStore];
        [reminder setTitle:eventName];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        [cal setTimeZone:[NSTimeZone localTimeZone]];
        [cal setLocale:[NSLocale currentLocale]];
        [reminder setStartDateComponents:[cal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit   | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]]];
        [reminder setDueDateComponents:[cal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit   | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]]];
        
        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:-660];
        //EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:3];
            
        reminder.alarms = [NSArray arrayWithObject:alarm];
        [reminder setCalendar:[_eventStore defaultCalendarForNewReminders]];
        
        NSError *err;
        BOOL savedCorrectly = [_eventStore saveReminder:reminder commit:YES error:&err];
        if (savedCorrectly)
            NSLog(@"Saved Correctly!");
        else
            NSLog(@"Better luck next time");
        } else {
            NSLog(@"You weren't even granted permission the first time");
        }
    }];
}

@end
