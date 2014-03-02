//
//  PSNewMessageView.h
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSNewMessageView : UIView
@property (weak, nonatomic) IBOutlet UITextField *messageToSendLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;

+ (NSString *)reuseIdentifier;
+ (NSString *)viewKind;

@end
