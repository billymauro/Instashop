//
//  DiscoverViewController.h
//  Instashop
//
//  Created by Josh Klobe on 9/11/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppRootViewController;
@interface DiscoverViewController : UIViewController
{
    AppRootViewController *parentController;
}
@property (nonatomic, retain) AppRootViewController *parentController;
@end
