//
//  SearchRequestObject.h
//  Instashop
//
//  Created by Josh Klobe on 9/4/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchRequestObject : NSObject
{
    NSArray *searchCategoriesArray;
    NSArray *searchFreeTextArray;
}

-(id)initWithCategoriesArray:(NSArray *)theCategoriesArray withFreeTextArray:(NSArray *)theFreeTextArray;

@property (nonatomic, retain) NSArray *searchCategoriesArray;
@property (nonatomic, retain) NSArray *searchFreeTextArray;
@end
