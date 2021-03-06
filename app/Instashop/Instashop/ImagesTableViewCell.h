//
//  ImagesTableViewCell.h
//  Instashop
//
//  Created by Josh Klobe on 5/24/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesTableViewItem.h"

@interface ImagesTableViewCell : UITableViewCell
{
    ImagesTableViewItem *itemOne;
    ImagesTableViewItem *itemTwo;
    ImagesTableViewItem *itemThree;
    
    BOOL stifleFlashRefresh;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withCellHeight:(float)cellHeight;
- (void) loadWithIndexPath:(NSIndexPath *)theIndexPath withFeedItemsArray:(NSArray *)feedItemsArray withDelegate:(id)delegate;
- (void) loadWithIndexPath:(NSIndexPath *)theIndexPath withSellerDictionaryArray:(NSArray *)sellerDictionaryArray withDelegate:(id)theDelegate;

@property (nonatomic, strong) ImagesTableViewItem *itemOne;
@property (nonatomic, strong) ImagesTableViewItem *itemTwo;
@property (nonatomic, strong) ImagesTableViewItem *itemThree;

@property (nonatomic, assign) BOOL stifleFlashRefresh;
@end
