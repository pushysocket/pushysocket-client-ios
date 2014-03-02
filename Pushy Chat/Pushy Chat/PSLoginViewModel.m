//
//  PSLoginViewModel.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSLoginViewModel.h"

@interface PSLoginViewModel ()

@property (nonatomic, strong) RACSignal *nameValidSignal;

@end

@implementation PSLoginViewModel

- (id)init {
    self = [super init];
    if (self) {
        [self mapLoginCommandStateToStatusMessage];
    }
    return self;
}

- (void)mapLoginCommandStateToStatusMessage {
    RACSignal *startedMessageSource = [self.loginCommand.executionSignals map:^id(RACSignal *loginSignal) {
        return NSLocalizedString(@"Logging In...", nil);
    }];
    
    RACSignal *completedMessageSource = [self.loginCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
        return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeCompleted;
        }] map:^id(id value) {
            return NSLocalizedString(@"Thanks", nil);
        }];
    }];
    
    RACSignal *failedMessageSource = [[self.loginCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        return NSLocalizedString(@"Error :(", nil);
    }];
    
    RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        //NSString *userName = self.userName;
        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithEnabled:self.nameValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self rac_loginWithName:self.userName];
        }];
    }
    return _loginCommand;
}

- (RACSignal *)rac_loginWithName:(NSString *)name {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if ([_client loginWithName:self.userName]) {
            [subscriber sendCompleted];
        }
        else {
            [subscriber sendError:nil];
        }
        return [RACDisposable disposableWithBlock:^{
            // Do Nothing
        }];
    }];
    
    [signal setName:@"rac_signalForLogin"];
    
    return signal;
}

- (RACSignal *)nameValidSignal {
    if (!_nameValidSignal) {
        _nameValidSignal = [RACObserve(self, userName) map:^id(NSString *userName) {
            return @(userName && ![userName isEqualToString:@""]);
        }];
    }
    return _nameValidSignal;
}

#pragma mark - PSClientDelegate

- (void)clientDidConnectToServer:(PSClient *)theClient {
    
}

- (void)clientDidDisconnectToServer:(PSClient *)theClient {
    
}

- (void)client:(PSClient *)theClient didSendMessage:(PSMessage *)aMessage {
    
}

- (void)client:(PSClient *)theClient didReceiveMessages:(NSArray *)messages {
}

@end
