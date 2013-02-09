//
//  OData.m
//  Test2
//
//  Created by Tanya Krumm on 2/9/13.
//  Copyright (c) 2013 Tanya Krumm. All rights reserved.
//

#import "OData.h"
#import <RestKit/RestKit.h>

@implementation OData

@synthesize title;

-(void)loadOData{
RKObjectMapping* oDataMapping = [RKObjectMapping mappingForClass:[OData class]];
[oDataMapping addAttributeMappingsFromDictionary:@{@"title" : @"title"}];

RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:oDataMapping pathPattern:nil keyPath:@"workspace" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

NSURL *URL = [NSURL URLWithString:@"http://6ee3591ae99340f496c78754219d1158.cloudapp.net/BisonTrackerDataService.svc/"];
NSURLRequest *request = [NSURLRequest requestWithURL:URL];
RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
[objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    RKLogInfo(@"Load collection of oData: %@", mappingResult.array);
} failure:^(RKObjectRequestOperation *operation, NSError *error) {
    RKLogError(@"Operation failed with error: %@", error);
}];

[objectRequestOperation start];
}
@end
