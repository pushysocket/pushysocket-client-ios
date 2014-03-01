//
//  PSConversationViewModel.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSClient;

@interface PSConversationViewModel : NSObject

@property (nonatomic, strong) PSClient * client;

@property (nonatomic, strong) NSMutableArray *messages;

- (RACSignal *)rac_signalForMessageReceived;

@end