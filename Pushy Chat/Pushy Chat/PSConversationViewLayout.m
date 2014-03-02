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

@end

@implementation PSConversationViewLayout

- (void)prepareLayout {
    
    
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 74.f);
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

@end
