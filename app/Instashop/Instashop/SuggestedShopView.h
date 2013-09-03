//
//  SuggestedShopView.h
//  Instashop
//
//  Created by Josh Klobe on 9/1/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestedShopView : UIView
{
    NSString *shopViewInstagramID;
    
    UILabel *titleLabel;
    UILabel *bioLabel;
    
    UIImageView *theBackgroundImageView;
    UIImageView *profileImageView;
    
    UIButton *followButton;
    
}

@property (nonatomic, retain) NSString *shopViewInstagramID;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *bioLabel;

@property (nonatomic, retain) IBOutlet UIImageView *theBackgroundImageView;
@property (nonatomic, retain) IBOutlet UIImageView *profileImageView;

@property (nonatomic, retain) IBOutlet UIButton *followButton;
@end
