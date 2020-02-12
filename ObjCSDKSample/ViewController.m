//
//  ViewController.m
//  ObjCSDKSample
//
//  Created by Andre Herculano on 10.05.19.
//  Copyright © 2019 sourcepoint. All rights reserved.
//

#import "ViewController.h"
@import ConsentViewController;

@interface ViewController ()<GDPRConsentDelegate> {
    GDPRConsentViewController *cvc;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GDPRPropertyName *propertyName = [[GDPRPropertyName alloc] init:@"mobile.demo" error:NULL];

    cvc = [[GDPRConsentViewController alloc]
           initWithAccountId:22
           propertyId:2372
           propertyName:propertyName
           PMId:@"5c0e81b7d74b3c30c6852301"
           campaignEnv:GDPRCampaignEnvPublic
           consentDelegate:self];

    [cvc loadMessage];
}

- (void)onConsentReadyWithGdprUUID:(NSString *)gdprUUID userConsent:(GDPRUserConsent *)userConsent {
    NSLog(@"ConsentUUID: %@", gdprUUID);
    NSLog(@"ConsentString: %@", userConsent.euconsent.consentString);
    for (id vendorId in userConsent.acceptedVendors) {
        NSLog(@"Consented to Vendor(id: %@)", vendorId);
    }
    for (id purposeId in userConsent.acceptedCategories) {
        NSLog(@"Consented to Purpose(id: %@)", purposeId);
    }
}
                                  
- (void)consentUIWillShow {
    [self presentViewController:cvc animated:true completion:NULL];
}

- (void)consentUIDidDisappear {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
