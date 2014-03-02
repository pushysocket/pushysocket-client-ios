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
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDoesRelativeDateFormatting:YES];
    
    RAC(self.messageLabel, text) = RACObserve(self, chatMessage.message);
    RAC(self.nameLabel, text) = RACObserve(self, chatMessage.name);
    RAC(self.timestampLabel, text) = [RACObserve(self, chatMessage.timestamp) map:^id(NSDate * timestamp) {
        return [dateFormatter stringFromDate:timestamp];
    }];
}

@end
