//
//  PSClient.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSClient.h"
#import "PSMessage.h"

#import <Foundation/NSJSONSerialization.h>

#import <socket.IO/SocketIO.h>
#import <Socket.IO/SocketIOPacket.h>

static NSString *PushySocketHost = @"pushysocket.nodejitsu.com";
static NSInteger PushySocketPort = 80;
static BOOL PushySocketSecure = NO;

@interface PSClient () <SocketIODelegate>

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
    
    _clientId = [[NSUUID UUID] UUIDString];
    return self;
}

- (BOOL)sendMessage:(NSString *)message { NSAssert(YES, @"Need to use subclass"); return NO; }
- (BOOL)loginWithName:(NSString *)name { NSAssert(YES, @"Need to use subclass"); return NO; }
- (BOOL)refreshMessages { NSAssert(YES, @"Need to use subclass"); return NO; }

@end
