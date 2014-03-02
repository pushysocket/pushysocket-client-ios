//
//  PSConversationViewModel.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationViewModel.h"

#import "PSMessage.h"

@interface PSConversationViewModel () < PSClientDelegate >

@property (nonatomic, weak) id<RACSubscriber> messageReceivedSubscriber;

@end

@implementation PSConversationViewModel

- (id)init {
    self = [super init];
    if (!self) return self;
    
    _messages = [NSMutableArray array];
    
    return self;
}

- (RACSignal *)rac_signalForMessageReceived {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        self.messageReceivedSubscriber = subscriber;
        return [RACDisposable disposableWithBlock:^{
            self.messageReceivedSubscriber = nil;
            // Do Nothing
        }];
    }];
    
    [signal setName:@"rac_signalForMessageReceived"];
    
    return signal;
}

#pragma mark - PSClientDelegate

- (void)clientDidConnectToServer:(PSClient *)theClient {
    
}

- (void)clientDidDisconnectToServer:(PSClient *)theClient {
    
}

- (void)client:(PSClient *)theClient didReceiveMessage:(PSMessage *)aMessage {
    [self.messages addObject:aMessage];
    [_messageReceivedSubscriber sendNext:aMessage];
}

@end
