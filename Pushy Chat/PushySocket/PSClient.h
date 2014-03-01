//
//  PSClient.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSClient;
@class PSMessage;

@protocol PSClientDelegate <NSObject>

- (void)clientDidConnectToServer:(PSClient *)theClient ;
- (void)clientDidDisconnectToServer:(PSClient *)theClient;

- (void)client:(PSClient *)theClient didReceiveMessage:(PSMessage *)aMessage;

@end

@interface PSClient : NSObject

@property (nonatomic, copy, readonly) NSString *host;
@property (nonatomic, copy, readonly) NSString *port;
@property (nonatomic, assign, getter = isConnected) BOOL connected;

@property (nonatomic, weak) id<PSClientDelegate> delegate;

- (void)sendMessage:(NSString *)message;

@end
