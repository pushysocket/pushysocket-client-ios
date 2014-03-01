//
//  PSConversationController.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSConversationViewModel;

@interface PSConversationController : UICollectionViewController

@property (nonatomic, strong) PSConversationViewModel *conversationViewModel;

@end
