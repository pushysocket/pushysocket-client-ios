//
//  PSConversationViewLayout.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationViewLayout.h"

@implementation PSConversationViewLayout

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    
    return self;
}

- (void)prepareLayout {
    
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 92.f);
//    self.sectionInset = UIEdgeInsetsMake(0.f, 0.f, 1.f, 0.f);
//    self.minimumInteritemSpacing = 1.f;
    self.minimumLineSpacing = 1.f;
}

@end
