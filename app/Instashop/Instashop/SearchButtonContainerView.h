//
//  SearchButtonContainerView.h
//  Instashop
//
//  Created by Josh Klobe on 9/12/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSiloViewController.h"

#define SEARCH_BUTTON_TYPE_CATEGORIES 0
#define SEARCH_BUTTON_TYPE_FREE 1


@interface SearchButtonContainerView : UIView
{
    NSString *searchTerm;
    int type;
    
    UILabel *searchLabel;
    UIImageView *exitImageView;
    UIButton *coverButton;
    
    SearchSiloViewController *referenceController;
    
}

-(void) loadWithSearchTerm:(NSString *)theSearchTerm withClickDelegate:(SearchSiloViewController *)searchSiloViewController;
-(void) sizeViewWithFrame;

@property (nonatomic, retain) NSString *searchTerm;
@property (nonatomic, assign) int type;

@property (nonatomic, retain) UILabel *searchLabel;
@property (nonatomic, retain) UIImageView *exitImageView;
@property (nonatomic, retain) UIButton *coverButton;
@property (nonatomic, retain) SearchSiloViewController *referenceController;

@end