//
//  AttributesManager.h
//  Instashop
//
//  Created by Josh Klobe on 6/25/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributesManager : NSObject

+(AttributesManager *)getSharedAttributesManager;

-(NSArray *)getTopCategories;
-(NSArray *)getSubcategoriesFromTopCategory:(NSString *)topCategory;
-(NSArray *)getAttributesFromTopCategory:(NSString *)topCategory fromSubcategory:(NSString *)subcategory;

@property (nonatomic, retain) NSMutableArray *attributesArray;
@end
