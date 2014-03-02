//
//  PSConversationViewModel.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PSClient.h"

@interface PSConversationViewModel : NSObject < PSClientDelegate >

@property (nonatomic, strong) PSClient * client;
@property (nonatomic, strong) RACCommand *sendMessageCommand;

// write to this property
@property (nonatomic, copy) NSString *messageToSend;


@property (nonatomic, strong) NSMutableArray *messages;

- (RACSignal *)rac_signalForMessageReceived;

@end
