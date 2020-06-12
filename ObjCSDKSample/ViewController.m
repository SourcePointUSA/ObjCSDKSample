//
//  ViewController.m
//  ObjCSDKSample
//
//  Created by Andre Herculano on 10.05.19.
//  Copyright © 2019 sourcepoint. All rights reserved.
//

#import "ViewController.h"
//@import ConsentViewController;
@import CCPAConsentViewController;

//@interface ViewController ()<GDPRConsentDelegate> {
//    GDPRConsentViewController *cvc;
//}
//@end

@interface ViewController ()<ConsentDelegate> {
    CCPAConsentViewController *ccpa;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    GDPRPropertyName *propertyName = [[GDPRPropertyName alloc] init:@"mobile.demo" error:NULL];

//    cvc = [[GDPRConsentViewController alloc]
//           initWithAccountId:22
//           propertyId:2372
//           propertyName:propertyName
//           PMId:@"5c0e81b7d74b3c30c6852301"
//           campaignEnv:GDPRCampaignEnvPublic
//           consentDelegate:self];

//    [cvc loadMessage];

    PropertyName *propertyName = [[PropertyName alloc] init:@"ccpa.mobile.demo" error:NULL];

    ccpa = [[CCPAConsentViewController alloc]
           initWithAccountId:22
           propertyId:6099
           propertyName:propertyName
           PMId:@"5df9105bcf42027ce707bb43"
           campaignEnv:CampaignEnvPublic
           consentDelegate:self];

    [ccpa loadMessage];
}

/// MARK - CCPA

- (void)consentUIWillShow {
    [self presentViewController:ccpa animated:true completion:NULL];
}

- (void)consentUIDidDisappear {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)onConsentReadyWithConsentUUID:(NSString *)consentUUID userConsent:(UserConsent *)userConsent {
    NSLog(@"ConsentUUID: %@", consentUUID);
    NSLog(@"US Privacy String: %@", userConsent.uspstring);
    NSLog(@"Consent status: %ld", (long)userConsent.status);
    for (id vendorId in userConsent.rejectedVendors) {
        NSLog(@"Rejected to Vendor(id: %@)", vendorId);
    }
    for (id purposeId in userConsent.rejectedCategories) {
        NSLog(@"Rejected to Purpose(id: %@)", purposeId);
    }
}

- (void)onErrorWithError:(CCPAConsentViewControllerError *)error {
    NSLog(@"Something went wrong: %@", error);
}

/// MARK - GPDR

//- (void)onConsentReadyWithGdprUUID:(NSString *)gdprUUID userConsent:(GDPRUserConsent *)userConsent {
//    NSLog(@"ConsentUUID: %@", gdprUUID);
//    NSLog(@"ConsentString: %@", userConsent.euconsent);
//    for (id vendorId in userConsent.acceptedVendors) {
//        NSLog(@"Consented to Vendor(id: %@)", vendorId);
//    }
//    for (id purposeId in userConsent.acceptedCategories) {
//        NSLog(@"Consented to Purpose(id: %@)", purposeId);
//    }
//}
                                  
//- (void)consentUIWillShow {
//    [self presentViewController:cvc animated:true completion:NULL];
//}

//- (void)consentUIDidDisappear {
//    [self dismissViewControllerAnimated:true completion:nil];
//}
@end
