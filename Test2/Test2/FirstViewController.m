//
//  FirstViewController.m
//  Test2
//
//  Created by Tanya Krumm on 2/6/13.
//  Copyright (c) 2013 Tanya Krumm. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize liveClient;
@synthesize infoLabel;

NSString* APP_CLIENT_ID=@"00000000480EA137";

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.liveClient = [[LiveConnectClient alloc] initWithClientId:APP_CLIENT_ID
                                                         delegate:self
                                                        userState:@"initialize"];
}

- (void)authCompleted:(LiveConnectSessionStatus) status
              session:(LiveConnectSession *) session
            userState:(id) userState
{
    if ([userState isEqual:@"initialize"])
    {
        [self.infoLabel setText:@"Initialized."];
        [self.liveClient login:self
                        scopes:[NSArray arrayWithObjects:@"wl.signin", nil]
                      delegate:self
                     userState:@"signin"];
    }
    if ([userState isEqual:@"signin"])
    {
        if (session != nil)
        {
            [self.infoLabel setText:@"Signed in."];
        }
    }
}

- (void)authFailed:(NSError *) error
         userState:(id)userState
{
    [self.infoLabel setText:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
