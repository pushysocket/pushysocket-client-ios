//
//  PSClient.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSClient.h"
#import "PSMessage.h"

#import <AZSocketIO/AZSocketIO.h>

static NSString *PushySocketHost = @"http://pushysocket.io";
static NSString *PushySocketPort = @"8923";
static BOOL PushySocketSecure = YES;

@interface PSClient ()

@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, assign, getter = isSecure) BOOL secure;

@property (nonatomic, strong) AZSocketIO *socketIO;

@end

@implementation PSClient

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    _host = PushySocketHost;
    _port = PushySocketPort;
    _secure = PushySocketSecure;
    
    _socketIO = [[AZSocketIO alloc] initWithHost:_host andPort:_port secure:_secure];
    
    @weakify(self)
    [_socketIO setEventRecievedBlock:^(NSString *eventName, id data) {
        PSMessage *message = [[PSMessage alloc] init];
        message.message = eventName;
        @strongify(self)
        [self.delegate client:self didReceiveMessage:message];
    }];
    
    [_socketIO connectWithSuccess:^{
        self.connected = YES;
    } andFailure:^(NSError *error) {
        self.connected = NO;
    }];
    
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        PSMessage *message = [[PSMessage alloc] init];
        message.message = @"Whats up";
        [self.delegate client:self didReceiveMessage:message];
    });
    
    
    return self;
}

- (void)sendMessage:(NSString *)message {
    [_socketIO send:message error:nil];
}


@end
