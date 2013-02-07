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
@end