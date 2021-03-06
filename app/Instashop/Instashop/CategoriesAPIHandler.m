//
//  CategoriesAPIHandler.m
//  Instashop
//  APIHandler used to download current categories list served by shopsy server
//  Created by Josh Klobe on 9/13/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "CategoriesAPIHandler.h"
#import "AttributesManager.h"

@implementation CategoriesAPIHandler

+(void)makeCategoriesRequest
{
    NSString *urlRequestString = [NSString stringWithFormat:@"%@/%@", [Utils getRootURI], @"categories3.plist"];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequestString]];
    
    
    
    CategoriesAPIHandler *categoriesAPIHandler = [[CategoriesAPIHandler alloc] init];
    categoriesAPIHandler.theWebRequest = [SMWebRequest requestWithURLRequest:URLRequest delegate:categoriesAPIHandler context:NULL];
    [categoriesAPIHandler.theWebRequest addTarget:categoriesAPIHandler action:@selector(categoriesRequestFinished:) forRequestEvents:SMWebRequestEventComplete];
    [categoriesAPIHandler.theWebRequest start];
   

//    NSLog(@"CategoriesAPIHandler urlRequestString: %@", urlRequestString);
}

-(void)categoriesRequestFinished:(id)obj
{
    NSString* newStr = [[NSString alloc] initWithData:self.responseData
                                              encoding:NSUTF8StringEncoding];
    
    [[AttributesManager getSharedAttributesManager] processAttributesString:newStr];
    
    
}
@end
