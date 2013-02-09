//
//  main.m
//  Test2
//
//  Created by Tanya Krumm on 2/6/13.
//  Copyright (c) 2013 Tanya Krumm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "OData.h"

int main(int argc, char *argv[])
{
    OData *odata = [OData alloc];
    NSLog(@"title:", odata.title);
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
