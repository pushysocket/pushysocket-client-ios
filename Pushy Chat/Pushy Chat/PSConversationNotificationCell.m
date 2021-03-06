//
//  PSConversationNotificationCell.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/2/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationNotificationCell.h"

#import <NSDate+RelativeTime.h>

@interface PSConversationNotificationCell ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation PSConversationNotificationCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    RAC(self.messageLabel, text) = [RACSignal combineLatest:@[RACObserve(self, message.message),
                                                              RACObserve(self, message.timestamp)]
                                                     reduce:^(NSString *message, NSDate *timestamp) {
                                                        return [NSString stringWithFormat:@"%@ %@",message, [timestamp relativeTime]];
                                                     }] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
