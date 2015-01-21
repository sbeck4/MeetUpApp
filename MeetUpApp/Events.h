//
//  Events.h
//  MeetUpApp
//
//  Created by Shannon Beck on 1/19/15.
//  Copyright (c) 2015 Shannon Beck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Events : NSObject

@property NSString *address;
@property NSString *rsvpCounts;
@property NSString *eventName;
@property NSString *hostingGroup;
@property NSString *eventDescription;
@property NSString *eventURL;
@property NSArray *membersNames;
@property NSString *commentTime;
@property NSString *comment;

@end
