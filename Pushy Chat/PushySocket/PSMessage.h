//
//  PSMessage.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSMessage : NSObject

@property (nonatomic, assign) NSString *message;
@property (nonatomic, assign) NSString *name;

@end
