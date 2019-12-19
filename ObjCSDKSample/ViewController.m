//
//  ViewController.m
//  ObjCSDKSample
//
//  Created by Andre Herculano on 10.05.19.
//  Copyright © 2019 sourcepoint. All rights reserved.
//

#import "ViewController.h"
@import CCPAConsentViewController;

@interface ViewController ()<ConsentDelegate>

@end

@implementation ViewController

CCPAConsentViewController *cvc;

- (void)viewDidLoad {
    [super viewDidLoad];

    cvc = [[CCPAConsentViewController alloc] initWithAccountId:22 propertyId:6099 property:@"ccpa.mobile.demo" PMId:@"5df9105bcf42027ce707bb43" campaign:@"prod" consentDelegate:self];
                                      
    [cvc loadMessage];
}

- (IBAction)onPrivacySettingsTap:(UIButton *)sender {
    [cvc loadPrivacyManager];
}

- (void)onConsentReadyWithConsentUUID:(NSString *)consentUUID userConsent:(UserConsent *)userConsent {
    NSLog(@"uuid: %@", consentUUID);
    NSLog(@"userConsent: %@", userConsent);
}

- (void)onErrorWithError:(CCPAConsentViewControllerError *)error {
    NSLog(@"Error: %@", error);
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)consentUIDidDisappear {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)consentUIWillShow {
    [self presentViewController:cvc animated:YES completion:NULL];
}

@end
