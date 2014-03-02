//
//  PSLoginViewController.m
//  Pushy Chat
//
//  Created by Ryan Crosby on 3/1/14.
//  Copyright (c) 2014 pushysocket. All rights reserved.
//

#import "PSLoginViewController.h"

#import "PSAppDelegate.h"
#import "PSClient.h"

#import "PSLoginViewModel.h"

#import <RACUnit.h>

#import "PSConversationController.h"
#import "PSConversationViewModel.h"

@interface PSLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *joinChatButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *statusField;

@property (strong, nonatomic) PSLoginViewModel *loginViewModel;

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
    
    PSAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.loginViewModel = [[PSLoginViewModel alloc] init];
    self.loginViewModel.client = appDelegate.pushySocketClient;
    
    
    RAC(self.loginViewModel, userName) = self.userNameTextField.rac_textSignal;
    self.joinChatButton.rac_command = self.loginViewModel.loginCommand;
    RAC(self.statusField, text) = RACObserve(self.loginViewModel, statusMessage);
    
    [[[self.loginViewModel.loginCommand executionSignals] flattenMap:^RACStream *(RACSignal *execution) {
        return [[execution ignoreValues] concat: [RACSignal return:RACUnit.defaultUnit]];
    }] subscribeNext:^(id x) {
        PSConversationViewModel *conversationViewModel = [[PSConversationViewModel alloc] init];
        self.loginViewModel.client.delegate = conversationViewModel;
        conversationViewModel.client = self.loginViewModel.client;
        
        PSConversationController *conversationController = [self.storyboard instantiateViewControllerWithIdentifier:@"PSConversationController"];
        conversationController.conversationViewModel = conversationViewModel;
        
        [self.navigationController pushViewController:conversationController animated:YES];
    }];
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
