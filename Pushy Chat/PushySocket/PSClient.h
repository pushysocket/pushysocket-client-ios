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

- (void)client:(PSClient *)theClient didReceiveMessages:(NSArray *)messages;
- (void)client:(PSClient *)theClient didSendMessage:(PSMessage *)aMessage;

@end

@interface PSClient : NSObject

@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger port;

@property (nonatomic, assign, getter = isConnected) BOOL connected;
@property (nonatomic, assign, getter = isLoggedIn) BOOL loggedIn;
@property (nonatomic, assign, getter = isSecure) BOOL secure;

@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy) NSString *pushRegistrationToken;

@property (nonatomic, weak) id<PSClientDelegate> delegate;

- (BOOL)sendMessage:(NSString *)message;
- (BOOL)loginWithName:(NSString *)name;

- (BOOL)refreshMessages;

@end
