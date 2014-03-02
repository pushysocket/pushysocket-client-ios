//
//  PSLoginViewModel.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PSClient.h"

@interface PSLoginViewModel : NSObject < PSClientDelegate >

@property (nonatomic, strong) PSClient * client;
@property (nonatomic, strong) RACCommand *loginCommand;

// write to this property
@property (nonatomic, copy) NSString *userName;

// read from this property
@property (nonatomic, copy, readonly) NSString *statusMessage;

@end
