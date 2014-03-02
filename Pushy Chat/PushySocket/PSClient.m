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

static NSString *PushySocketHost = @"pushysocket.nodejitsu.com";
static NSString *PushySocketPort = @"80";
static BOOL PushySocketSecure = NO;

@interface PSClient ()

@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, assign, getter = isSecure) BOOL secure;
@property (nonatomic, assign, getter = isConnected) BOOL connected;
@property (nonatomic, assign, getter = isLoggedIn) BOOL loggedIn;

@property (nonatomic, strong) AZSocketIO *socketIO;

@end

@implementation PSClient

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    _host = PushySocketHost;
    _port = PushySocketPort;
    _secure = PushySocketSecure;
    _connected = NO;
    _loggedIn = NO;
    
    _socketIO = [[AZSocketIO alloc] initWithHost:_host andPort:_port secure:_secure withNamespace:@"/chat"];
    
    @weakify(self)
    [_socketIO setEventRecievedBlock:^(NSString *eventName, id data) {
        if ([eventName isEqualToString:@"message"]) {
            @strongify(self)
            NSString *messageBody = data[0][@"message"];
            NSString *user = data[0][@"user"];
            PSMessage *message = [[PSMessage alloc] init];
            message.message = messageBody;
            message.name = user;
            [self.delegate client:self didReceiveMessage:message];
        }
    }];
    
    [_socketIO setDisconnectedBlock:^{
        NSLog(@"did Disconnect");
    }];
    
    
    [_socketIO connectWithSuccess:^{
        @strongify(self);
        self.connected = YES;
        
        [self loginWithName:@"ios-client-adam"];
    } andFailure:^(NSError *error) {
        @strongify(self);
        self.connected = NO;
    }];
    
    return self;
}

- (BOOL)loginWithName:(NSString *)name {
    if (!_connected) return NO;
    
    NSError *anError = nil;
    BOOL success = [_socketIO emit:@"login" args:@{@"name":@"ios"} error:&anError];
    NSLog(@"anError: %@", anError);
    
    self.loggedIn = success;
    
    return success;
}

- (void)sendMessage:(NSString *)message {
    [_socketIO send:message error:nil];
}


@end
