//
//  PSClientSocketIO.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/2/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSClientSocketIO.h"

#import "PSMessage.h"

#import <socket.IO/SocketIO.h>
#import <Socket.IO/SocketIOPacket.h>

@interface PSClientSocketIO () <SocketIODelegate>

@property (nonatomic, strong) SocketIO *socketIO;

@end

@implementation PSClientSocketIO

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    _socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    [_socketIO connectToHost:self.host onPort:self.port withParams:nil withNamespace:@"/chat"];
    //[_socketIO connectToHost:self.host onPort:self.port];
    
    return self;
}

- (BOOL)loginWithName:(NSString *)name {
    if (!self.connected) return NO;
    
    [_socketIO sendEvent:@"login" withData:@{@"name":name}];
    
    return YES;
}

- (BOOL)sendMessage:(NSString *)message {
    //    if (!_connected || !_loggedIn) return NO;
    
    [_socketIO sendEvent:@"message" withData:@{@"message":message}];
    //[_socketIO sendMessage:message];
    //NSDictionary *payload = @{@"args": @[@{@"message":message}], @"name":@"message"};
    
    //[_socketIO sendEvent:@"message" withData:[NSJSONSerialization dataWithJSONObject:payload options:0 error:nil]];
    //[_socketIO sendJSON:payload];
    
    return YES;
}

#pragma mark - Socket.IO Delegate

- (void)socketIODidConnect:(SocketIO *)socket {
    self.connected = YES;
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error {
    self.connected = NO;
}

//- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet;
//- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet;

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    if ([packet.name isEqualToString:@"message"]) {
        NSObject *jsonData = packet.dataAsJSON;
        
        //        NSString *messageBody = packet.data[0][@"message"];
        //        NSString *user = packet.data[0][@"user"][@"name"];
        PSMessage *message = [[PSMessage alloc] init];
        //        message.message = messageBody;
        //        message.name = user;
        [self.delegate client:self didReceiveMessage:message];
    }
}

- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet {
    NSLog(@"packet received: %@", packet.endpoint);
    if ([packet.name isEqualToString:@"login"]) {
        self.loggedIn = YES;
    }
    else if ([packet.name isEqualToString:@"message"]) {
        
    }
}

//- (void) socketIO:(SocketIO *)socket onError:(NSError *)error;

@end

