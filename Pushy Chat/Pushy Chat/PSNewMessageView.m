//
//  PSNewMessageView.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSNewMessageView.h"

#import <QuartzCore/QuartzCore.h>

@interface PSNewMessageView ()

@end

@implementation PSNewMessageView

+ (NSString *)reuseIdentifier { return @"chatTextField"; }
+ (NSString *)viewKind { return @"chatTextField"; }

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)awakeFromNib {
    self.layer.borderColor = [[UIColor redColor] CGColor];
    self.layer.borderWidth = 1.f;
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
