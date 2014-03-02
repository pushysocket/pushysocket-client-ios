//
//  PSConversationViewLayout.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationViewLayout.h"

#import "PSNewMessageView.h"

@interface PSConversationViewLayout ()

@property (nonatomic, weak) PSNewMessageView *messageEditView;
@property (nonatomic, assign) CGFloat keyboardHeight;

@end

@implementation PSConversationViewLayout

- (id)initWithCoder:(NSCoder *)aDecoder {
//- (id)init {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    
    _keyboardHeight = 0.f;
//    [self registerNib:[UINib nibWithNibName:@"PSNewMessageView" bundle:nil] forDecorationViewOfKind:[PSNewMessageView viewKind]];
//    [self registerNotifications];
    
    return self;
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

- (void)prepareLayout {
    
    
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 92.f);
//    self.sectionInset = UIEdgeInsetsMake(0.f, 0.f, 1.f, 0.f);
//    self.minimumInteritemSpacing = 1.f;
    self.minimumLineSpacing = 1.f;
}

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
//    
//    return [attributes arrayByAddingObject:[self layoutAttributesForDecorationViewOfKind:[PSNewMessageView viewKind] atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] ]];
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *decorationAttributes = nil;
//    if ([decorationViewKind isEqualToString:[PSNewMessageView viewKind]]) {
//        if (indexPath.row == 0 && indexPath.section == 0) {
//            decorationAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
//            
//            CGFloat textFieldHeight = 75.f;
//            CGFloat x = 0.f;
//            CGFloat adjustedY = self.collectionView.contentOffset.y + CGRectGetHeight(self.collectionView.bounds) - _keyboardHeight - textFieldHeight;
//            
//            
//            decorationAttributes.frame = CGRectMake(x, adjustedY, CGRectGetWidth(self.collectionView.bounds), textFieldHeight);
//            decorationAttributes.zIndex = 100;
//        }
//    }
//    
//    return decorationAttributes;
//}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds { return YES; }

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
    
    
    [self invalidateLayout];
//  PSNewMessageView *newMessageView = [self.collectionView.delegate col]
//
//    if(notification) {
//        [UIView animateWithDuration:animationDuration
//                              delay:0
//                            options:UIViewAnimationOptionAllowUserInteraction
//                         animations:^{
//                             [_messageEditView setFrame:newMessageViewRect];
//                         } completion:NULL];
//    }
//    else {
//        [_messageEditView setFrame:newMessageViewRect];
//        [self moveToPoint:newCenter rotateAngle:rotateAngle];
//    }
    
}

@end
