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
    GDPRNativeMessageViewController *nativeMessageController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GDPRPropertyName *propertyName = [[GDPRPropertyName alloc] init:@"tcfv2.mobile.demo" error:NULL];

    cvc = [[GDPRConsentViewController alloc]
           initWithAccountId: 22
           propertyId: 7094
           propertyName: propertyName
           PMId: @"179657"
           campaignEnv: GDPRCampaignEnvPublic
           consentDelegate: self];

    [cvc loadNativeMessageForAuthId:NULL];
}

-(void)consentUIWillShowWithMessage:(GDPRMessage *)message {
    nativeMessageController = [[GDPRNativeMessageViewController alloc] initWithMessageContents:message consentViewController:cvc];
    nativeMessageController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:nativeMessageController animated:true completion:NULL];
}

- (void)gdprPMWillShow {
    if (nativeMessageController.viewIfLoaded.window != nil) {
        [nativeMessageController presentViewController:cvc animated:true completion:NULL];
    } else {
        [self presentViewController:nativeMessageController animated:true completion:NULL];
    }
}

- (void)onAction:(GDPRAction *)action {
    switch (action.type) {
        case GDPRActionTypePMCancel:
        case GDPRActionTypeDismiss:
            [self dismissConsentUI];
            break;
        case GDPRActionTypeShowPrivacyManager:
            break;
        default:
            [cvc reportAction:action];
            [self dismissViewControllerAnimated:true completion:NULL];
            break;
    }
}

- (void)consentUIDidDisappear {
    [self dismissViewControllerAnimated:true completion:NULL];
}

- (void)onConsentReadyWithGdprUUID:(NSString *)gdprUUID userConsent:(GDPRUserConsent *)userConsent {
    NSLog(@"ConsentUUID: %@", gdprUUID);
    NSLog(@"ConsentString: %@", userConsent.euconsent);
    for (id vendorId in userConsent.acceptedVendors) {
        NSLog(@"Consented to Vendor(id: %@)", vendorId);
    }
    for (id purposeId in userConsent.acceptedCategories) {
        NSLog(@"Consented to Purpose(id: %@)", purposeId);
    }
}

- (void)onErrorWithError:(GDPRConsentViewControllerError *)error {
    NSLog(@"%@", error);
}

- (void)dismissConsentUI {
    if (nativeMessageController.viewIfLoaded.window != nil) {
        [nativeMessageController dismissViewControllerAnimated:true completion:NULL];
    } else {
        [self dismissViewControllerAnimated:true completion:NULL];
    }
}
@end
