//
//  FirstViewController.m
//  Test2
//
//  Created by Tanya Krumm on 2/6/13.
//  Copyright (c) 2013 Tanya Krumm. All rights reserved.
//

#import "FirstViewController.h"
#import <RestKit/RestKit.h>
#import "OData.h"
#import "/Users/MacPC/test/Test2/Dependencies/RKXMLReaderSerialization.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize liveClient;
@synthesize infoLabel;
@synthesize title;
@synthesize nameLabel;
@synthesize genderLabel;
@synthesize profileLinkLabel;
@synthesize profilePictureView;

NSString* APP_CLIENT_ID=@"00000000480EA137";

- (void)viewDidLoad
{
    [super viewDidLoad];
	//self.liveClient = [[LiveConnectClient alloc] initWithClientId:APP_CLIENT_ID delegate:self userState:@"initialize"];
    FirstViewController *oData = [[FirstViewController alloc]init];
    [oData loadOData];
        
}

- (void)authCompleted:(LiveConnectSessionStatus) status
              session:(LiveConnectSession *) session
            userState:(id) userState
{
    if ([userState isEqual:@"initialize"])
    {
        [self.infoLabel setText:@"Initialized."];
        [self.liveClient login:self
                        scopes:[NSArray arrayWithObjects:@"wl.basic", nil]
                      delegate:self
                     userState:@"signin"];
    }
    if ([userState isEqual:@"signin"])
    {
        if (session != nil)
        {
            [self.infoLabel setText:@"Signed in as "];
            NSString *signInButtonText = (session == nil)? @"Sign in": @"Sign out";
            [self.btnSignIn setTitle:signInButtonText
                               forState:UIControlStateNormal];
        }
    }
}

- (void)authFailed:(NSError *) error
         userState:(id)userState
{
    [self.infoLabel setText:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]]];
}

- (void) getMe
{
    if (self.liveClient) {
        [self.liveClient getWithPath:@"me"
                            delegate:self
                           userState:@"me"];
        [self.liveClient getWithPath:@"me/picture"
                            delegate:self
                           userState:@"me-picture"];
    }
}

- (void) liveOperationSucceeded:(LiveOperation *)operation
{
    if ([operation.userState isEqual:@"me"]) {
        [self.nameLabel setText:[operation.result objectForKey:@"name"] ];
        self.genderLabel.text = [operation.result objectForKey:@"gender"];
        self.profileLinkLabel.text = [operation.result objectForKey:@"link"];
    }
    if ([operation.userState isEqual:@"me-picture"]) {
        NSString *location = [operation.result objectForKey:@"location"];
        if (location) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:location]];
            self.profilePictureView.image = [UIImage imageWithData:data];
        }
    }
}


-(void)loadOData{
    RKObjectMapping* oDataMapping = [RKObjectMapping mappingForClass:[OData class]];
    [oDataMapping addAttributeMappingsFromDictionary:@{@"name" : @"name",@"url":@"url"}];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:oDataMapping pathPattern:nil keyPath:@"value" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:@"http://6ee3591ae99340f496c78754219d1158.cloudapp.net/BisonTrackerDataService.svc/?&$format=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of oData: %@", mappingResult.array);
        int limit = mappingResult.array.count;
        int i;
        for (i = 0; i < limit; i++) {
            OData *answer = mappingResult.array[i];
            RKLogInfo(@"Data name: %@",[answer name]);
            RKLogInfo(@"Data url: %@",[answer url]);
            self.infoLabel.text = @"Data name: %@",[answer name];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonButton:(id)sender {
    if (self.liveClient.session == nil)
    {  self.liveClient = [[LiveConnectClient alloc] initWithClientId:APP_CLIENT_ID delegate:self userState:@"initialize"];
    }else{
        [self.liveClient logoutWithDelegate:self
                              userState:@"signout"];
    }

    /*LiveOperation *operation = [[LiveOperation alloc]init];
    [oData liveOperationSucceeded:operation];//[self.liveClient getWithPath:@"me" delegate:self userState:@"me"]];*/

}

- (IBAction)donebtn:(id)sender {
    
    FirstViewController *oData = [[FirstViewController alloc]init];
    [oData getMe];
    self.infoLabel.text = [self.liveClient.session.scopes componentsJoinedByString:@","];
    NSLog(@"test",[self.liveClient.session.scopes componentsJoinedByString:@","]);
    self.nameLabel.text= liveClient.session.authenticationToken;
     
}
@end
