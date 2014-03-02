//
//  PSConversationController.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationController.h"

#import "PSConversationMessageCell.h"

#import "PSConversationViewModel.h"

#import "PSMessage.h"

@interface PSConversationController ()

@end

@implementation PSConversationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.conversationViewModel.rac_signalForMessageReceived subscribeNext:^(PSMessage *message) {
        [self.collectionView reloadData];
//        NSInteger section = 0;
//        NSInteger lastRow = [self.collectionView numberOfItemsInSection:section];
//        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:lastRow inSection:section];
//        
//        [self.collectionView insertItemsAtIndexPaths:@[nextIndexPath]];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.conversationViewModel.messages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PSConversationMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"conversationCell" forIndexPath:indexPath];
   
    [cell setMessage:self.conversationViewModel.messages[indexPath.row]];
    
    return cell;
}

@end
