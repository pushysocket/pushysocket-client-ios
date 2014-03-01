//
//  PSConversationController.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSConversationController.h"

#import "PSConversationMessageCell.h"

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
	// Do any additional setup after loading the view.
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
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PSConversationMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"conversationCell" forIndexPath:indexPath];
    
    
    PSMessage *message;
    
    switch (indexPath.row % 3) {
        case 0:
            message = [[PSMessage alloc] init];
            message.message = @"Whats up";
            break;
            
        case 1:
            message = [[PSMessage alloc] init];
            message.message = @"I'm hungry";
            break;
            
        default:
        case 2:
            message = [[PSMessage alloc] init];
            message.message = @"You should try that one app";
            break;
    }
    
    [cell setMessage:message];
    
    return cell;
}

@end
