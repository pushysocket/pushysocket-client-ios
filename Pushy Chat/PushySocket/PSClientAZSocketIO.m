//
//  PSClientAZSocketIO.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/2/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSClientAZSocketIO.h"

#import "PSMessage.h"

#import <AZSocketIO/AZSocketIO.h>

@interface PSClientAZSocketIO ()

@property (nonatomic, strong) AZSocketIO *socketIO;

@end

@implementation PSClientAZSocketIO

- (id)init {
    self = [super init];
    if (!self) return nil;
    
//    _socketIO = [[AZSocketIO alloc] initWithHost:self.host andPort:[NSString stringWithFormat:@"%ld",(long)self.port] secure:self.secure];
    _socketIO = [[AZSocketIO alloc] initWithHost:self.host andPort:[NSString stringWithFormat:@"%ld",(long)self.port] secure:self.secure withNamespace:@"/chat"];
    
    @weakify(self)
    [_socketIO setEventRecievedBlock:^(NSString *eventName, id data) {
        if ([eventName isEqualToString:@"message"]) {
            @strongify(self)
            NSString *messageBody = data[0][@"message"];
            NSString *user = data[0][@"user"][@"name"];
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
    } andFailure:^(NSError *error) {
        @strongify(self);
        self.connected = NO;
    }];
    
    return self;
}

- (BOOL)loginWithName:(NSString *)name {
    if (!self.connected) return NO;
    
    NSError *anError = nil;
    BOOL success = [_socketIO emit:@"login" args:@{@"name":name} error:&anError];
    if (anError) NSLog(@"anError: %@", anError);
    
    self.loggedIn = success;
    
    return success;
}

- (BOOL)sendMessage:(NSString *)message {
    NSError *anError = nil;
    BOOL success = [_socketIO emit:@"message" args:@{@"message":message} error:&anError];
    if (anError) NSLog(@"anError: %@", anError);
    
    return success;
}


@end
