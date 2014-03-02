//
//  PSMessage.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSMessage.h"

@implementation PSMessageFactory

+ (NSArray *)messagesWithEvent:(NSString *)event andData:(id)data {
    
    NSArray *messages = nil;
    
    if ([event isEqualToString:@"refresh"]) {
        if ([data[0] isKindOfClass:[NSArray class]]) {
            NSArray *dataList = (NSArray *)data[0];
            NSMutableArray *msgs = [NSMutableArray array];
            for (id data in dataList) {
                [msgs addObject:[PSChatMessage messageWithEvent:@"message" andData:data]];
            }
            messages = [msgs copy];
        }
    }
    else if ([event isEqualToString:@"message"]) {
        messages = @[[PSChatMessage messageWithEvent:event andData:data[0]]];
    }
    else if ([event isEqualToString:@"left"]) {
        messages = @[[PSLeftMessage messageWithEvent:event andData:data[0]]];
    }
    else if ([event isEqualToString:@"join"]) {
        messages = @[[PSJoinedMessage messageWithEvent:event andData:data[0]]];
    }
    else {
        NSLog(@"Warning: Did not handle message");
    }
  
    return messages;
}

@end

@implementation PSChatMessage

+ (id<PSMessageProtocol>)messageWithEvent:(NSString *)event andData:(id)data {
    PSChatMessage *chatMessage = [[PSChatMessage alloc] init];
    chatMessage.message = data[@"message"];
    chatMessage.name = data[@"user"][@"name"];
    
    return chatMessage;
}

+ (NSString *)messageType {
    return @"message";
}

@end

@implementation PSJoinedMessage
+ (id<PSMessageProtocol>)messageWithEvent:(NSString *)event andData:(id)data {
    PSJoinedMessage *joinMessage = [[PSJoinedMessage alloc] init];
    joinMessage.message = data[@"message"];
    joinMessage.name = data[@"user"][@"name"];
    
    return joinMessage;
}

+ (NSString *)messageType {
    return @"join";
}
@end

@implementation PSLeftMessage

+ (id<PSMessageProtocol>)messageWithEvent:(NSString *)event andData:(id)data {
    PSLeftMessage *leftMessage = [[PSLeftMessage alloc] init];
    leftMessage.message = data[@"message"];
    leftMessage.name = data[@"user"][@"name"];
    
    return leftMessage;
}

+ (NSString *)messageType {
    return @"join";
}

@end

