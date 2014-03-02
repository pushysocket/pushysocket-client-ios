//
//  PSConversationMessageCell.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSMessage;

@interface PSConversationMessageCell : UICollectionViewCell

@property (nonatomic, weak) PSMessage *message;

@end
