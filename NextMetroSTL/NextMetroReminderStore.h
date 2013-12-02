//
//  NextMetroReminderStore.h
//  NextMetroSTL
//
//  Created by Mike Menne on 11/25/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface NextMetroReminderStore : NSObject

+ (NextMetroReminderStore*) reminders;

- (id) initWithEventStore:(EKEventStore*)eventStore;
- (BOOL) ableToScheduleReminders;
- (void) addEvent:(NSString*)eventName;

@end
