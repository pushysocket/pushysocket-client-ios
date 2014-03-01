//
//  PSFriendsListController.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 2/28/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSFriendsListController.h"

#import "PSClient.h"

#import "PSConversationViewModel.h"
#import "PSConversationController.h"

@interface PSFriendsListController ()

@end

@implementation PSFriendsListController

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
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"playerCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UIViewController Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PSConversationViewModel *conversationViewModel = [[PSConversationViewModel alloc] init];
    
    PSClient *client = [[PSClient alloc] init];
    
    client.delegate = conversationViewModel;
    conversationViewModel.client = client;
    
    PSConversationController *conversationController = (PSConversationController *)segue.destinationViewController;
    
    conversationController.conversationViewModel = conversationViewModel;
}

@end
