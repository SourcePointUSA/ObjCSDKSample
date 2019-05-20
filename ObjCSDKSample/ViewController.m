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

    ConsentViewController *cvc = [[ConsentViewController alloc] initWithAccountId:22 siteName:@"mobile.demo" stagingCampaign:false andReturnError:nil];

    [cvc setTargetingParamString:@"MyPrivacyManager" value:@"true"];

    [cvc setOnMessageReady:^(ConsentViewController * consentSDK) {
        [self presentViewController:consentSDK animated:false completion:NULL];
    }];

    [cvc setOnInteractionComplete:^(ConsentViewController * consentSDK) {
        [consentSDK getCustomPurposeConsentsWithCompletionHandler:^(NSArray<PurposeConsent *>* purposeConsents) {
            NSLog(@"User has given consent to the purposes: %@", purposeConsents);
        }];

        [consentSDK dismissViewControllerAnimated:false completion:NULL];
    }];

    [cvc loadMessage];
}


@end
