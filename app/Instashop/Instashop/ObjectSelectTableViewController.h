//
//  ObjectSelectTableViewController.h
//  Instashop
//
//  Created by Josh Klobe on 9/12/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellSelectionOccuredProtocol.h"
#import "Instagram.h"
#import "FeedRequestFinishedProtocol.h"
#import "SearchRequestObject.h"
#import "SearchAPIHandler.h"
#import "SearchReturnedReceiverProtocol.h"

#define PRODUCT_REQUESTOR_TYPE_FEED_PRODUCTS 1
#define PRODUCT_REQUESTOR_TYPE_FEED_INSTAGRAM_SELLER 2
#define PRODUCT_REQUESTOR_TYPE_FEED_INSTAGRAM_BUYER 3
#define PRODUCT_REQUESTOR_TYPE_SEARCH 4


@interface ObjectSelectTableViewController : UITableViewController <IGRequestDelegate, CellSelectionOccuredProtocol, FeedRequestFinishedProtocol, SearchReturnedReceiverProtocol>
{
    id parentController;
    id cellDelegate;
    id rowSelectedDelegate;
    
    NSMutableArray *contentArray;
    NSMutableDictionary *contentRequestParameters;
    
    UITableView *referenceTableView;
    
    
    int productRequestorType;
    NSString *productRequestorReferenceObject;
    
    SearchRequestObject *searchRequestObject;
}

-(void)refreshContent;

@property (nonatomic, retain) id parentController;
@property (nonatomic, retain) id cellDelegate;
@property (nonatomic, retain) id rowSelectedDelegate;

@property (nonatomic, retain) NSMutableArray *contentArray;
@property (nonatomic, retain) NSMutableDictionary *contentRequestParameters;

@property (nonatomic, retain) UITableView *referenceTableView;

@property (nonatomic, assign) int productRequestorType;
@property (nonatomic, retain) NSString *productRequestorReferenceObject;

@property (nonatomic, retain) SearchRequestObject *searchRequestObject;

@end