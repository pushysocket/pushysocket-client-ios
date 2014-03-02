//
//  PSLoginViewController.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSLoginViewController.h"

#import "PSClient.h"

#import "PSConversationViewModel.h"
#import "PSConversationController.h"

@interface PSLoginViewController ()

@end

@implementation PSLoginViewController

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
