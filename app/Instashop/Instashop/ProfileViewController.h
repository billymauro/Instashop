//
//  ProfileViewController.h
//  Instashop
//
//  Created by Josh Klobe on 8/23/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGRequest.h"
#import "FeedRequestFinishedProtocol.h"


@interface ProfileViewController : UIViewController <IGRequestDelegate, FeedRequestFinishedProtocol, UITableViewDataSource, UITableViewDelegate>
{
    NSString *profileInstagramID;
    
    UIImageView *backgroundImageView;
    UIImageView *profileImageView;
    UILabel *usernameLabel;
    UILabel *followersLabel;
    UILabel *followingLabel;

    NSMutableArray *feedItemsArray;
    UITableView *theTableView;
    
}

@property (nonatomic, retain) NSString *profileInstagramID;

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, retain) IBOutlet UIImageView *profileImageView;
@property (nonatomic, retain) IBOutlet UILabel *usernameLabel;
@property (nonatomic, retain) IBOutlet UILabel *followersLabel;
@property (nonatomic, retain) IBOutlet UILabel *followingLabel;

@property (nonatomic, retain) NSMutableArray *feedItemsArray;
@property (nonatomic, retain) IBOutlet UITableView *theTableView;
@end