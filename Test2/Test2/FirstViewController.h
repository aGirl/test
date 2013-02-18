//
//  FirstViewController.h
//  Test2
//
//  Created by Tanya Krumm on 2/6/13.
//  Copyright (c) 2013 Tanya Krumm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveSDK/LiveConnectClient.h"

@interface FirstViewController : UIViewController<LiveAuthDelegate, LiveOperationDelegate, LiveDownloadOperationDelegate, LiveUploadOperationDelegate> 
@property (strong, nonatomic) LiveConnectClient *liveClient;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileLinkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
- (IBAction)buttonButton:(id)sender;
- (IBAction)donebtn:(id)sender;
@end