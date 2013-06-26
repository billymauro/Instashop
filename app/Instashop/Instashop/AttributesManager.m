//
//  AttributesManager.m
//  Instashop
//
//  Created by Josh Klobe on 6/25/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "AttributesManager.h"


@implementation AttributesManager


static AttributesManager *theManager;

@synthesize attributesArray;

+(AttributesManager *)getSharedAttributesManager;
{
    if (theManager == nil)
    {
        theManager = [[AttributesManager alloc] init];
    }
    return theManager;
}

-(id)init
{
    self = [super init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"attributes" ofType:@"csv"];
    if (filePath) {
        
        self.attributesArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSString *myText = [NSString stringWithContentsOfFile:filePath];
        
        NSMutableDictionary *outermostDictionary = nil;
        
        NSString *innerKey = nil;
        
        NSArray *linesArray = [myText componentsSeparatedByString:@"\n"];
        
        for (int i = 0; i < [linesArray count]; i++)
        {
            NSArray *lineObjects = [[linesArray objectAtIndex:i] componentsSeparatedByString:@","];
            
            if ([lineObjects count] == 3)
            {
//                NSLog(@"lineObjects[%d]: %@", i, lineObjects);
                
                if ([[lineObjects objectAtIndex:0] length] > 0)
                {
                    if (outermostDictionary != nil)
                        [self.attributesArray addObject:outermostDictionary];

                    outermostDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
                    [outermostDictionary setObject:[NSMutableDictionary dictionaryWithCapacity:0] forKey:[lineObjects objectAtIndex:0]];
                }
                else if ([[lineObjects objectAtIndex:1] length] > 0)
                {
                    
                    NSMutableDictionary *outermostContentDictionary = [outermostDictionary objectForKey:[[outermostDictionary allKeys] objectAtIndex:0]];
                    
                    innerKey = [lineObjects objectAtIndex:1];
                    
                    NSMutableDictionary *theDictionary = [outermostContentDictionary objectForKey:innerKey];
                    
                    if (theDictionary == nil)
                    {
                        [outermostContentDictionary setObject:[[NSMutableDictionary alloc] initWithCapacity:0] forKey:innerKey];
                    }
                }
                else if ([[lineObjects objectAtIndex:2] length] > 0)
                {                                        
                    
                    NSMutableDictionary *outermostContentDictionary = [outermostDictionary objectForKey:[[outermostDictionary allKeys] objectAtIndex:0]];
                    NSMutableDictionary *innerDictionary = [outermostContentDictionary objectForKey:innerKey];
                    
                    NSString *key = [lineObjects objectAtIndex:2];
  //                  NSLog(@"key: %@", key);
//                    NSLog(@"innerKey: %@", innerKey);
                    
                    [innerDictionary setObject:[NSMutableDictionary dictionaryWithCapacity:0] forKey:key];
                    
                }
            }
        }
        if (outermostDictionary != nil)
        {
            [self.attributesArray addObject:outermostDictionary];
        }
    }
    
//    NSLog(@"attributesArray: %@", attributesArray);
    return self;
}

-(NSArray *)getTopCategories
{
    NSMutableArray *ar = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < [self.attributesArray count]; i++)
    {
        NSDictionary *dict = [self.attributesArray objectAtIndex:i];
        [ar addObject:[[dict allKeys] objectAtIndex:0]];
    }
    return ar;
}

-(NSArray *)getSubcategoriesFromTopCategory:(NSString *)topCategory
{
    NSMutableArray *retAr = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *desiredDict = nil;
    for (int i = 0; i < [self.attributesArray count]; i++)
    {
        NSDictionary *dict = [self.attributesArray objectAtIndex:i];
        if ([((NSString *)[[dict allKeys] objectAtIndex:0]) compare:topCategory] == NSOrderedSame)
            desiredDict = dict;
    }
    if (desiredDict != nil)
        [retAr addObjectsFromArray:[[desiredDict objectForKey:[[desiredDict allKeys] objectAtIndex:0]] allKeys]];

    
    return retAr;
}

-(NSArray *)getAttributesFromTopCategory:(NSString *)topCategory fromSubcategory:(NSString *)subcategory
{
    NSMutableArray *retAr = [NSMutableArray arrayWithCapacity:0];
    
    NSDictionary *desiredDict = nil;
    for (int i = 0; i < [self.attributesArray count]; i++)
    {
        NSDictionary *dict = [self.attributesArray objectAtIndex:i];
        if ([((NSString *)[[dict allKeys] objectAtIndex:0]) compare:topCategory] == NSOrderedSame)
            desiredDict = dict;
    }
    if (desiredDict != nil)
    {        
        NSDictionary *dict = [desiredDict objectForKey:topCategory];
        dict = [dict objectForKey:subcategory];
        [retAr addObjectsFromArray:[dict allKeys]];

    }
    

    return retAr;
}
@end
