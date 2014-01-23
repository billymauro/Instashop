//
//  FirstTimeUserViewController.m
//  Instashop
//
//  Created by Susan Yee on 9/11/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "FirstTimeUserViewController.h"
#import "AppDelegate.h"
#import "DiscoverViewController.h"
#import "SuggestedStoresViewController.h"
#import "ISConstants.h"
#import "ShopsAPIHandler.h"
@interface FirstTimeUserViewController ()

@end


#define kButtonHeight 100.0

@implementation FirstTimeUserViewController

// So the FirstTimeViewController may lag a little bit because it is trying to add the SuggestedViewController into it which takes a little bit of time.  Think this can better be fixed by concurrent programming than anything else.

@synthesize tutorialScrollView;
@synthesize pageControl;
@synthesize loginTutorialDone;
@synthesize parentViewController;
@synthesize suggestedStoresViewController;
@synthesize enterEmailViewController;
@synthesize nextButton;
@synthesize suggestedFollowCount;
@synthesize emailComplete;
@synthesize hasPresentedSuggestedStores;
@synthesize suggestedButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    
    UIColor *textColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    
    // Scroll View
    self.tutorialScrollView = [[UIScrollView alloc] initWithFrame:screenBound];
    self.tutorialScrollView.pagingEnabled = YES;
    self.tutorialScrollView.showsHorizontalScrollIndicator = NO;
    self.tutorialScrollView.backgroundColor = [UIColor blackColor];
    self.tutorialScrollView.bounces = NO;  // Empty side view
    self.tutorialScrollView.delegate = self;
    [self.view addSubview:self.tutorialScrollView];
    
    
    NSString *zeroString = [NSString stringWithFormat:@"THIS IS ZERO STRING"];
    NSString *firstString = [NSString stringWithFormat:@"Tell followers where to buy the products you post on Instagram"];
    NSString *secondString = [NSString stringWithFormat:@"Buy products from your favorite retailers and brands"];
    NSString *thirdString = [NSString stringWithFormat:@"Save products for later purchase or gift ideas"];
    NSString *fourthString = [NSString stringWithFormat:@"Experience a simple and seamless checkout process"];
    
    NSArray *arrayOfStringLabels = [[NSArray alloc] initWithObjects:zeroString, firstString, secondString, thirdString, fourthString, nil];
    NSArray *arrayOfImages = [[NSArray alloc] initWithObjects:@"FirstTTutorialZero.png", @"FirstTTutorialOne.png", @"FirstTTutorialTwo.png", @"FirstTTutorialThree.png", @"FirstTTutorialFour.png", nil];
    
    
    for (int p = 0; p < [arrayOfImages count]; p++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(p * screenWidth, 0.0, screenWidth, screenHeight + 44.0)];
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lightMenuBG.png"]];
        [backgroundImage setFrame:CGRectMake(0.0, 0.0, screenWidth, screenHeight)];
        [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
        [view addSubview:backgroundImage];
        UIImage *image = [UIImage imageNamed:[arrayOfImages objectAtIndex:p]];
        int yPosition = 120.0; // change yPosition to position the iPhone image.
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, yPosition, screenWidth, screenHeight - yPosition)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [imageView setImage:image];
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 0.0, screenWidth - 60.0, 150.0)];
        label.text = [arrayOfStringLabels objectAtIndex:p];
        label.font = [UIFont fontWithName:@"Helvetica Neue Light" size:1.0];
        label.textColor = textColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 3;
        [view addSubview:label];
    
        [self.tutorialScrollView addSubview:view];
    }
    
    // Enter email View Controller
    
    self.enterEmailViewController = [[EnterEmailViewController alloc] initWithNibName:@"EnterEmailViewController" bundle:nil];
    self.enterEmailViewController.view.frame = CGRectMake(0.0, 20.0, screenWidth, screenHeight);
    self.enterEmailViewController.firstTimeUserViewController = self;

    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.enterEmailViewController];
    [navigationController.navigationBar setBarTintColor:[ISConstants getISGreenColor]];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    navigationController.navigationBar.translucent = NO;
    navigationController.view.frame = CGRectMake(screenWidth * 5, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    [navigationController.view addSubview:self.enterEmailViewController.view];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = @"Enter Email?";
    [label sizeToFit];
    
    navigationController.navigationItem.titleView = label;
    navigationController.navigationItem.titleView.backgroundColor = [UIColor redColor];
    [self.tutorialScrollView addSubview:navigationController.view];

    
    float buttonSize = 50.0; // Change this number to change the button position.
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth * 5, screenHeight - buttonSize, screenWidth, buttonSize)];
    self.nextButton.enabled = NO;
    
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"Menu-BG.png"] forState:UIControlStateDisabled];
    [self.nextButton setTitle:@"Next" forState:UIControlStateDisabled];
    self.nextButton.titleLabel.textColor = [UIColor whiteColor];
    self.nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.nextButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:3.0];
    [self.nextButton setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.75]];
    [self.nextButton addTarget:self action:@selector(nextButtonHit) forControlEvents:UIControlEventTouchUpInside];
    [self.tutorialScrollView addSubview:self.nextButton];
    
    
    // SuggestViewController
    
    self.suggestedStoresViewController = [[SuggestedStoresViewController alloc] initWithNibName:@"SuggestedStoresViewController" bundle:nil];
    self.suggestedStoresViewController.holdBegin = YES;
    self.suggestedStoresViewController.view.frame = CGRectMake(screenWidth * 6, 0.0, screenWidth, screenHeight);
    self.suggestedStoresViewController.firstTimeUserViewController = self;
//    [self.suggestedStoresViewController.view addSubview:self.nextButton];
    [self.tutorialScrollView addSubview:self.suggestedStoresViewController.view];
  
    
    self.suggestedButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenHeight - buttonSize, screenWidth, buttonSize)];
    self.suggestedButton.enabled = NO;
    
    [self.suggestedButton setBackgroundImage:[UIImage imageNamed:@"Menu-BG.png"] forState:UIControlStateDisabled];
    [self.suggestedButton setTitle:@"Please Follow 5 Stores" forState:UIControlStateDisabled];
    [self.suggestedButton setTitle:@"Go!" forState:UIControlStateNormal];
    self.suggestedButton.titleLabel.textColor = [UIColor whiteColor];
    self.suggestedButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.suggestedButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:3.0];
    [self.suggestedButton setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.75]];
    [self.suggestedButton addTarget:self action:@selector(suggestedButtonHit) forControlEvents:UIControlEventTouchUpInside];
    [self.suggestedStoresViewController.view addSubview:self.suggestedButton];

    
    
    // Page Control
    
    self.pageControl = [[UIPageControl alloc] init];
    float pageControlHeight = 40.0;
    self.pageControl.frame = CGRectMake(0.0, screenHeight - pageControlHeight, screenWidth, pageControlHeight);
    self.pageControl.enabled = YES;
    self.pageControl.numberOfPages = [arrayOfImages count];
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    
    
    
    self.tutorialScrollView.contentSize = CGSizeMake(navigationController.view.frame.origin.x + navigationController.view.frame.size.width, 33.3);
    
}

-(void)suggestedButtonHit
{
    NSLog(@"suggestedButtonHit");
    if (self.suggestedFollowCount >= 5)
    {
        [self closeTutorial];
    }
}

-(void)nextButtonHit
{
    if (self.emailComplete && !self.hasPresentedSuggestedStores)
    {
        
        self.hasPresentedSuggestedStores = YES;
        [self.nextButton setTitle:@"Please Follow 5 Stores" forState:UIControlStateDisabled];
        
        self.tutorialScrollView.contentSize = CGSizeMake(self.suggestedStoresViewController.view.frame.origin.x + self.suggestedStoresViewController.view.frame.size.width, 33.3);
        [self.tutorialScrollView setContentOffset:CGPointMake(self.suggestedStoresViewController.view.frame.origin.x, 0) animated:YES];
        [self handleButtonState];
    }
    
    
    
}

-(void)emailPageComplete
{
    self.emailComplete = YES;
    self.nextButton.enabled = YES;
    self.nextButton.backgroundColor = [ISConstants getISGreenColor];
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
}


-(void)handleButtonState
{
    NSLog(@"handleButtonState: %d", self.suggestedFollowCount);
        if (self.suggestedFollowCount >= 5)
        {
            self.suggestedButton.enabled = YES;
            self.suggestedButton.backgroundColor = [ISConstants getISGreenColor];
        }
        else if (self.suggestedFollowCount < 5)
        {
            self.suggestedButton.enabled = NO;
          //  self.suggestedButton.backgroundColor = [UIColor clearColor];
            
        }
    
    
}
- (void) shopWasFollowed
{
    self.suggestedFollowCount++;
    
    [self handleButtonState];
}

- (void) shopWasUnFollowed
{
    self.suggestedFollowCount--;
    
    if (self.suggestedFollowCount < 0)
        self.suggestedFollowCount = 0;
    
    [self handleButtonState];
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.suggestedStoresViewController.begun)
    {
        self.suggestedStoresViewController.begun = YES;
        [ShopsAPIHandler getSuggestedShopsWithDelegate:self.suggestedStoresViewController];
    }
    
    CGFloat pageWidth = self.tutorialScrollView.frame.size.width;
    float fractionalPage = self.tutorialScrollView.contentOffset.x/pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
    if (page < 4)
        self.pageControl.hidden = NO;
    else
        self.pageControl.hidden = YES;
    
}


- (void) moveScrollView {
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;

    [self.tutorialScrollView setContentOffset:CGPointMake(self.tutorialScrollView.contentOffset.x + screenWidth, 0) animated:YES];
}

- (void) closeTutorial {
    NSLog(@"closeTutorial");
    if (self.suggestedFollowCount < 5)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hey"
                                                            message:@"Do please follow 5 shops"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    else
        [self.parentViewController firstTimeTutorialExit];
}


@end
