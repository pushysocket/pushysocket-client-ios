//
//  PSMessage.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ENUM(NSUInteger, PSMessageType)

typedef NS_ENUM(NSInteger, PSMessageType) {
    PSMessageTypeBasic,
    PSMessageTypeJoinNotification,
    PSMessageTypeLeftNotification,
};

@protocol PSMessageProtocol <NSObject>

@property (nonatomic, copy) NSString *message;

@end

@interface PSMessage : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *name;

@end
