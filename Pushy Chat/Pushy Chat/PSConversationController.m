//
//  PSConversationController.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationController.h"

#import "PSConversationNotificationCell.h"
#import "PSConversationMessageCell.h"
#import "PSNewMessageView.h"

#import "PSConversationViewModel.h"

#import "PSMessage.h"

static const CGFloat PushySocketNewMessageViewHeight = 51.f;

@interface PSConversationController () <UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayoutDelegate;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, weak) PSNewMessageView *messageCreateView;

@end

@implementation PSConversationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self registerNotifications];
    }
    return self;
}

- (void)awakeFromNib {
    [self registerNotifications];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangedNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangedNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangedNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangedNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PSNewMessageView *messageView = [[[NSBundle mainBundle] loadNibNamed:@"PSNewMessageView" owner:self options:nil] objectAtIndex:0];
    self.messageCreateView = messageView;
    [self updateMessageFrame];
    [self.view addSubview:messageView];
    

    [self.conversationViewModel.rac_signalForMessagesReceived subscribeNext:^(NSArray *messages) {
        NSInteger section = 0;
        NSInteger lastRow = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (int c = 0; c < [messages count]; c++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:(lastRow + c) inSection:section]];
        }
        
       [self.collectionView insertItemsAtIndexPaths:indexPaths];
       [self.collectionView scrollToItemAtIndexPath:[indexPaths lastObject] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    }];
    
    RAC(self.conversationViewModel, messageToSend) = self.messageCreateView.messageToSendLabel.rac_textSignal;
    self.messageCreateView.sendMessageButton.rac_command = self.conversationViewModel.sendMessageCommand;
    
    [[self.conversationViewModel.sendMessageCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribedSignal) {
        return [[subscribedSignal ignoreValues] concat:[RACSignal return:RACUnit.defaultUnit]];
    }] subscribeNext:^(id x) {
        self.messageCreateView.messageToSendLabel.text = nil;
        [self.messageCreateView.messageToSendLabel resignFirstResponder];
        NSLog(@"Done");
    }];
    
    [self.conversationViewModel.client refreshMessages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateMessageFrame {
    CGFloat x = 0.f;
    CGFloat adjustedY = CGRectGetHeight(self.view.bounds) - _keyboardHeight - PushySocketNewMessageViewHeight;
    
    CGRect messageFrame = CGRectMake(x, adjustedY, CGRectGetWidth(self.collectionView.bounds), PushySocketNewMessageViewHeight);
    [self.messageCreateView setFrame:messageFrame];
    
    UIEdgeInsets oldInsets = self.collectionView.contentInset;
    self.collectionView.contentInset = UIEdgeInsetsMake(oldInsets.top, oldInsets.left, (_keyboardHeight + PushySocketNewMessageViewHeight), oldInsets.right);
}


- (void)keyboardChangedNotification:(NSNotification*)notification {
    
    CGFloat keyboardHeight;
    double animationDuration;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(notification) {
        NSDictionary* keyboardInfo = [notification userInfo];
        CGRect keyboardFrame = [[keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        animationDuration = [[keyboardInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        if(notification.name == UIKeyboardWillShowNotification || notification.name == UIKeyboardDidShowNotification) {
            if(UIInterfaceOrientationIsPortrait(orientation))
                keyboardHeight = keyboardFrame.size.height;
            else
                keyboardHeight = keyboardFrame.size.width;
        } else
            keyboardHeight = 0;
    } else {
        keyboardHeight = self.keyboardHeight;
    }
    
    _keyboardHeight = keyboardHeight;
    

    if(notification) {
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             [self updateMessageFrame];
                         } completion:NULL];
    }
    else {
        [self updateMessageFrame];
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.conversationViewModel.messages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id<PSMessageProtocol> message = self.conversationViewModel.messages[indexPath.row];
    
    if ([message isKindOfClass:[PSChatMessage class]]) {
        PSConversationMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"conversationCell" forIndexPath:indexPath];
       
        [cell setChatMessage:(PSChatMessage *)message];
        
        return cell;
    }
    else {
        PSConversationNotificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"notificationCell" forIndexPath:indexPath];
        [cell setMessage:message];
        
        return cell;
    }
    
}

#pragma mark - UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id<PSMessageProtocol> message = self.conversationViewModel.messages[indexPath.row];
    CGSize cellSize;
    
    if ([message isKindOfClass:[PSChatMessage class]]) {
        cellSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 94.f);
    }
    else {
        cellSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 39.f);
    }
    
    return cellSize;
}



@end
