//
//  FeedViewController.m
//  Instashop
//
//  Created by Josh Klobe on 5/31/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "FeedViewController.h"
#import "AppRootViewController.h"
#import "ImagesTableViewCell.h"
#import "ImageAPIHandler.h"
#import "PurchasingViewController.h"
#import "ISConstants.h"


@interface FeedViewController ()

@end

@implementation FeedViewController

@synthesize parentController;
@synthesize feedItemsArray, selectedObject;
@synthesize productSelectTableViewController;
@synthesize theTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.feedItemsArray = [[NSMutableArray alloc] initWithCapacity:0];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self.navigationController.navigationBar setBarTintColor:[ISConstants getISGreenColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;

    UIView *homeCustomView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 23, 20)];
    
    UIImageView *homeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenuButton.png"]];
    homeImageView.frame = CGRectMake(0,0,23,20);
    [homeCustomView addSubview:homeImageView];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(0,0,homeCustomView.frame.size.width, homeCustomView.frame.size.height);
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton addTarget:self action:@selector(homeButtonHit) forControlEvents:UIControlEventTouchUpInside];
    [homeCustomView addSubview:homeButton];
    
    UIBarButtonItem *homBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeCustomView];
    self.navigationItem.leftBarButtonItem = homBarButtonItem;
    

    UIView *discoverCustomView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 44, 44)];
    
    UIImageView *discoverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magnify.png"]];
    discoverImageView.frame = CGRectMake(22,11,22,22);
    [discoverCustomView addSubview:discoverImageView];
    
    UIButton *discoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    discoverButton.frame = CGRectMake(0,0,discoverCustomView.frame.size.width, discoverCustomView.frame.size.height);
    [discoverButton addTarget:self action:@selector(discoverButtonHit) forControlEvents:UIControlEventTouchUpInside];
    [discoverCustomView addSubview:discoverButton];
    
    UIBarButtonItem *discoverBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:discoverCustomView];
    self.navigationItem.rightBarButtonItem = discoverBarButtonItem;


    UIImageView *theImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toolbarISLogo.png"]];
    self.navigationItem.titleView = theImageView;
    
    self.productSelectTableViewController.cellDelegate = self;
    self.productSelectTableViewController.productRequestorType = PRODUCT_REQUESTOR_TYPE_FEED_PRODUCTS;
    [self.productSelectTableViewController refreshContent];
    
    NSLog(@"self.view.subviews: %@", [self.view subviews]);
    
}



-(IBAction)homeButtonHit
{
    [self.parentController homeButtonHit];
}

-(IBAction)notificationsButtonHit
{
    NSLog(@"notificationsButtonHit");
    [self.parentController notificationsButtonHit];
}

-(IBAction)discoverButtonHit
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Coming Soon!"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    [alertView show];
}





-(void) cellSelectionOccured:(NSDictionary *)theSelectionObject
{
    self.selectedObject = theSelectionObject;

    PurchasingViewController *purchasingViewController = [[PurchasingViewController alloc] initWithNibName:@"PurchasingViewController" bundle:nil];
    purchasingViewController.parentController = self;
    purchasingViewController.requestingProductID = [theSelectionObject objectForKey:@"product_id"];
    purchasingViewController.view.frame = CGRectMake(0, 0, purchasingViewController.view.frame.size.width, purchasingViewController.view.frame.size.height);
    [self.navigationController pushViewController:purchasingViewController animated:YES];
    
}






@end
