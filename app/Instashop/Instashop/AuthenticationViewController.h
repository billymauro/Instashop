//
//  AuthenticationViewController.h
//  Instashop
//
//  Created by Josh Klobe on 5/22/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instagram.h"
#import "SellerExistsResponderProtocol.h"
#import "JKProgressView.h"

#define  TUTORIAL_COMPLETE  @"TUTORIAL_COMPLETE1"


@interface AuthenticationViewController : UIViewController <IGSessionDelegate, IGRequestDelegate, UIWebViewDelegate, SellerExistsResponderProtocol>
{
    UIWebView *loginWebView;
    
    UIViewController *instagramLoginWebViewController;
    UILabel *backLabel;
    UIButton *backButton;
    
    UIView *iphoneShortView;
    
    JKProgressView *progressView;
}


-(IBAction) loginButtonHit;
-(IBAction) downloadButtonHit;

-(void)makeLoginRequestWithURL:(NSURL *)theURL;

@property (nonatomic, strong) UIWebView *loginWebView;

@property (nonatomic, strong) UIViewController *instagramLoginWebViewController;
@property (nonatomic, strong) UILabel *backLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) BOOL firstTimeUser;

@property (nonatomic, strong) IBOutlet UIView *iphoneShortView;

@property (nonatomic, strong) JKProgressView *progressView;
@end
