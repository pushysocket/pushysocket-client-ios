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
    if (data[@"id"]) chatMessage.identifier = data[@"id"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *date = [dateFormatter dateFromString:data[@"timestamp"]];
    if (date) chatMessage.timestamp = date;
    
    return chatMessage;
}

+ (NSString *)messageType {
    return @"message";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%@) - %@", self.identifier, self.message, self.timestamp];
}

@end

@implementation PSJoinedMessage
+ (id<PSMessageProtocol>)messageWithEvent:(NSString *)event andData:(id)data {
    PSJoinedMessage *joinMessage = [[PSJoinedMessage alloc] init];
    joinMessage.name = data[@"user"][@"name"];
    joinMessage.message = [NSString stringWithFormat:@"%@ joined the conversation", joinMessage.name];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *date = [dateFormatter dateFromString:data[@"timestamp"]];
    if (date) joinMessage.timestamp = date;
    
    return joinMessage;
}

+ (NSString *)messageType {
    return @"join";
}
@end

@implementation PSLeftMessage

+ (id<PSMessageProtocol>)messageWithEvent:(NSString *)event andData:(id)data {
    PSLeftMessage *leftMessage = [[PSLeftMessage alloc] init];
    leftMessage.message = data[@"name"];
    leftMessage.message = [NSString stringWithFormat:@"%@ left the conversation", leftMessage.name];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *date = [dateFormatter dateFromString:data[@"timestamp"]];
    if (date) leftMessage.timestamp = date;
    
    return leftMessage;
}

+ (NSString *)messageType {
    return @"join";
}

@end

