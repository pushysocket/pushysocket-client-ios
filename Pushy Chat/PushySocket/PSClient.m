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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)sendMessage:(NSString *)message { NSAssert(YES, @"Need to use subclass"); return NO; }
- (BOOL)loginWithName:(NSString *)name { NSAssert(YES, @"Need to use subclass"); return NO; }
- (BOOL)refreshMessages { NSAssert(YES, @"Need to use subclass"); return NO; }
- (BOOL)pauseChat { NSAssert(NO, @"Don't do that"); return NO; }
- (BOOL)resumeChat { NSAssert(NO, @"Don't do that"); return NO; }

- (void)applicationDidEnterBackground {
    [self pauseChat];
}

- (void)applicationDidBecomeActive {
    [self resumeChat];
}

@end
