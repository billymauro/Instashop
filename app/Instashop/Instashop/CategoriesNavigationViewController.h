//
//  CategoriesNavigationViewController.h
//  Instashop
//
//  Created by Josh Klobe on 8/7/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesTableViewController.h"

@interface CategoriesNavigationViewController : UINavigationController
{
    NSMutableArray *selectedCategoriesArray;
}

-(void)categorySelected:(NSString *)theCategory withCallingController:(CategoriesTableViewController *)callingController;

@property (nonatomic, retain) NSMutableArray *selectedCategoriesArray;
@end
