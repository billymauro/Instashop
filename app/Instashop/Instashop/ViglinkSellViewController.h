//
//  ViglinkSellViewController.h
//  Instashop
//
//  Created by Josh Klobe on 9/23/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViglinkSellViewController : UIViewController <UISearchBarDelegate, UIWebViewDelegate>
{
    id delegate;
    
    UIView *webContainerView;
    UIWebView *theWebView;
    UISearchBar *webSearchBar;
    
}

-(IBAction)backButtonHit;
-(IBAction)selectPageLinkButtonHit;

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) IBOutlet UIView *webContainerView;
@property (nonatomic, retain) IBOutlet UIWebView *theWebView;
@property (nonatomic, retain) IBOutlet UISearchBar *webSearchBar;

@end
