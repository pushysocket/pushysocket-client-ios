//
//  PSConversationMessageCell.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationMessageCell.h"

#import "PSMessage.h"

@interface PSConversationMessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation PSConversationMessageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    RAC(self.messageLabel, text) = RACObserve(self, message.message);
    RAC(self.nameLabel, text) = RACObserve(self, message.name);
}

@end
