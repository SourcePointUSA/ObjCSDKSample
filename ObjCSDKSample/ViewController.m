//
//  ViewController.m
//  ObjCSDKSample
//
//  Created by Andre Herculano on 10.05.19.
//  Copyright © 2019 sourcepoint. All rights reserved.
//

#import "ViewController.h"
@import ConsentViewController;

@interface ViewController ()<ConsentDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ConsentViewController *cvc = [[ConsentViewController alloc] initWithAccountId:22 siteId:2372 siteName:@"mobile.demo" PMId:@"5c0e81b7d74b3c30c6852301" campaign:@"stage" showPM:false consentDelegate:self andReturnError:nil];

    [cvc loadMessage];
}

- (void)onConsentReadyWithController:(ConsentViewController * _Nonnull)controller {
    [controller getCustomVendorConsentsWithCompletionHandler:^(NSArray<VendorConsent *> * vendors, ConsentViewControllerError * error) {
        if (error != nil) {
            [self onErrorOccurredWithError:error];
        }else {
            for (id vendor in vendors) {
                NSLog(@"Consented to: %@", vendor);
            }
        }
    }];
    [controller dismissViewControllerAnimated:false completion:NULL];
}

- (void)onErrorOccurredWithError:(ConsentViewControllerError * _Nonnull)error {
    NSLog(@"Error: %@", error);
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)onMessageReadyWithController:(ConsentViewController * _Nonnull)controller {
    [self presentViewController:controller animated:false completion:NULL];
}

@end
