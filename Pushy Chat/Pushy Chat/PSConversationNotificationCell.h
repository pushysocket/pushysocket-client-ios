//
//  PSConversationNotificationCell.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/2/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PSMessage.h"

@interface PSConversationNotificationCell : UICollectionViewCell

@property (nonatomic, weak) id<PSMessageProtocol> message;

@end
