//
//  PSMessage.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSMessageProtocol <NSObject>

@property (nonatomic, copy) NSString *message;

+ (id<PSMessageProtocol>)messageWithEvent:(NSString *)event andData:(id)data;

+ (NSString *)messageType;
- (NSString *)name;

@end

@interface PSMessageFactory : NSObject

+ (NSArray *)messagesWithEvent:(NSString *)event andData:(id)data;

@end

@interface PSChatMessage : NSObject < PSMessageProtocol >

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *name;

@end

@interface PSJoinedMessage : NSObject < PSMessageProtocol >

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *name;

@end

@interface PSLeftMessage : NSObject < PSMessageProtocol >

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *name;

@end