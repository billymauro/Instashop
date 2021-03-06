//
//  EnterEmailViewController.h
//  Instashop
//
//  Created by Susan Yee on 12/27/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesViewController.h"
#import "InterestsViewController.h"
@class FirstTimeUserViewController;

@interface EnterEmailViewController : UIViewController <UITextFieldDelegate>
{
    InterestsViewController *interestsViewController;
    FirstTimeUserViewController *firstTimeUserViewController;
    UILabel *categoriesLabel;
    UITextField *enterNameTextField;
    UIButton *tosButton;
    UISegmentedControl *theSegmentedControl;
    UIView *tosContainerView;
    UIButton *nextCoverButton;
    UIButton *nextButton;
}

-(IBAction)tosLinkButtonHit;
-(IBAction)categoriesButtonHit;
-(IBAction)tosButtonHit;
-(void)categorySelectionCompleteWithString:(NSString *)theCategory;


@property (nonatomic, strong) InterestsViewController *interestsViewController;
@property (nonatomic, strong) FirstTimeUserViewController *firstTimeUserViewController;
@property (nonatomic, strong) IBOutlet UIView *enterEmailView;
@property (nonatomic, strong) IBOutlet UITextField *enterNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *enterEmailTextField;
@property (nonatomic, strong) IBOutlet UILabel *categoriesLabel;
@property (nonatomic, strong) IBOutlet UIButton *tosButton;

@property (nonatomic, strong) IBOutlet UISegmentedControl *theSegmentedControl;
@property (nonatomic, strong) IBOutlet UIView *tosContainerView;
@property (nonatomic, strong) UIButton *nextCoverButton;
@property (nonatomic, strong) UIButton *nextButton;
@end
