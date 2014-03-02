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

@property (nonatomic, strong) RACSignal *messageToSendValidSignal;
@property (nonatomic, weak) id<RACSubscriber> messageReceivedSubscriber;

@end

@implementation PSConversationViewModel

- (id)init {
    self = [super init];
    if (!self) return self;
    
    _messages = [NSMutableArray array];
    
    return self;
}

- (RACSignal *)rac_signalForMessagesReceived {
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

- (RACCommand *)sendMessageCommand {
    if (!_sendMessageCommand) {
        //NSString *messageToSend = self.messageToSend;
        @weakify(self);
        _sendMessageCommand = [[RACCommand alloc] initWithEnabled:self.messageToSendValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self rac_sendMessage:self.messageToSend];
        }];
    }
    return _sendMessageCommand;
}

- (RACSignal *)rac_sendMessage:(NSString *)theMessage {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if ([_client sendMessage:theMessage]) {
            [subscriber sendCompleted];
            self.messageToSend = nil;
        }
        else {
            [subscriber sendError:nil];
        }
        return [RACDisposable disposableWithBlock:^{
            // Do Nothing
        }];
    }];
    
    [signal setName:@"rac_signalForMessageSending"];
    
    return signal;
}

- (RACSignal *)messageToSendValidSignal {
    if (!_messageToSendValidSignal) {
        _messageToSendValidSignal = [RACObserve(self, messageToSend) map:^id(NSString *theMessage) {
            return @(theMessage && ![theMessage isEqualToString:@""]);
        }];
    }
    return _messageToSendValidSignal;
}

#pragma mark - PSClientDelegate

- (void)clientDidConnectToServer:(PSClient *)theClient {
    
}

- (void)clientDidDisconnectToServer:(PSClient *)theClient {
    
}

- (void)client:(PSClient *)theClient didSendMessage:(PSMessage *)aMessage {
    
}

- (void)client:(PSClient *)theClient didReceiveMessages:(NSArray *)messages {
    @weakify(self);
    RACSequence *messages_seq = [messages.rac_sequence filter:^BOOL(id<PSMessageProtocol> maybeNewMessage) {
        @strongify(self);
        [self.messages.rac_sequence objectPassingTest:^BOOL(id<PSMessageProtocol> existingMessage) {
            BOOL sameClass = [maybeNewMessage isKindOfClass:[existingMessage class]];
            BOOL isChatMessage = [maybeNewMessage isKindOfClass:[PSChatMessage class]];
            
            if (sameClass && isChatMessage) {
                return [((PSChatMessage *)maybeNewMessage).identifier isEqualToString:((PSChatMessage *)existingMessage).identifier];
            }
            else if (sameClass) {
                return [maybeNewMessage.timestamp isEqualToDate:existingMessage.timestamp];
            }
            else {
                return NO;
            }
        }];
    }];
    
    NSArray *newMessages = messages_seq.array;
    if (newMessages) {
        [self.messages addObjectsFromArray:newMessages];
        [_messageReceivedSubscriber sendNext:newMessages];
    }
}

@end
