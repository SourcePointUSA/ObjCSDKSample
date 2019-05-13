//
//  ViewController.m
//  ObjCSDKSample
//
//  Created by Andre Herculano on 10.05.19.
//  Copyright © 2019 sourcepoint. All rights reserved.
//

#import "ViewController.h"
@import ConsentViewController;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ConsentViewController * error = nil;

    ConsentViewController *cvc = [[ConsentViewController alloc] initWithAccountId:22 siteName:@"mobile.demo" stagingCampaign:false andReturnError:&error];
    __weak typeof(cvc) weakConsentViewController = cvc;

    NSLog(@"Something bad happened while building ConsentViewController: %@", error);

    // this is optional, we're just adding custom targetting parameters to be used in the SourcePoint's portal
    [cvc setTargetingParamString:@"CMP" value:@"true"];

    [cvc setOnMessageReady:^(ConsentViewController * consentSDK) {
        [self presentViewController:consentSDK animated:false completion:NULL];
    }];

    [cvc setOnInteractionComplete:^(ConsentViewController * consentSDK) {
        [consentSDK getCustomPurposeConsentsWithCompletionHandler:^(NSArray<PurposeConsent *>* purposeConsents) {
            NSLog(@"User has given consent to the purposes: %@", purposeConsents);
        }];

        [consentSDK getCustomVendorConsentsWithCompletionHandler:^(NSArray<VendorConsent *> * vendorConsents) {
            NSLog(@"User has given consent to the vendors: %@", vendorConsents);
        }];

        ConsentViewControllerError * inError = nil;
        NSArray *iabVendorIds = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
        NSArray *iabConsents = [consentSDK getIABVendorConsents:iabVendorIds error: &inError];
        NSLog(@"User has given IAB Consent to the purposes: %@", iabConsents[0]);
        NSLog(@"User has given IAB Consent to the purposes: %@", iabConsents[1]);

//        [consentSDK.view removeFromSuperview];
        [consentSDK dismissViewControllerAnimated:false completion:NULL];

        NSLog(@"onInteractionComplete: %@", inError);
    }];

    [cvc setOnErrorOccurred:^(ConsentViewControllerError * error) {
        [weakConsentViewController dismissViewControllerAnimated:false completion:NULL];
        NSLog(@"onErrorOccurred: %@", error);
    }];

    [cvc loadMessage];
}


@end
