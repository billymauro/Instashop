//
//  CreateProductAPIHandler.m
//  Instashop
//
//  Created by Josh Klobe on 7/16/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "CreateProductAPIHandler.h"
#import "InstagramUserObject.h"

@implementation CreateProductAPIHandler

+(void)createProductContainerObject:(id)delegate withProductCreateObject:(ProductCreateObject *)theProductCreateObject
{
    
    NSString *urlRequestString = [NSString stringWithFormat:@"%@/%@", ROOT_URI, @"create_product.php"];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequestString]];
    URLRequest.HTTPMethod = @"POST";
    
    InstagramUserObject *userInstagramObject = [InstagramUserObject getStoredUserObject];
    
    
    NSMutableString *postString = [NSMutableString stringWithCapacity:0];
    [postString appendString:@"create_type=product_object"];
    [postString appendString:[NSString stringWithFormat:@"instagramUserId=%@&", userInstagramObject.userID]];
    [postString appendString:[NSString stringWithFormat:@"instagramProductId=%@&", [theProductCreateObject.instragramMediaInfoDictionary objectForKey:@"id"]]];
    [postString appendString:[NSString stringWithFormat:@"object_title=%@&", theProductCreateObject.title]];
    [postString appendString:[NSString stringWithFormat:@"object_description=%@", theProductCreateObject.description]];     
    [postString appendString:[NSString stringWithFormat:@"object_quantity=%@&", theProductCreateObject.quantity]];
    [postString appendString:[NSString stringWithFormat:@"object_price=%@&", theProductCreateObject.retailPrice]];
    [postString appendString:[NSString stringWithFormat:@"object_weight=%@&", theProductCreateObject.shippingWeight]];
    [postString appendString:[NSString stringWithFormat:@"object_image_urlstring=%@&", theProductCreateObject.instagramPictureURLString]];

/*    [postString appendString:[NSString stringWithFormat:@"&object_attribute_one=%@", [attributesArray objectAtIndex:0]]];
    [postString appendString:[NSString stringWithFormat:@"&object_attribute_two=%@", [attributesArray objectAtIndex:1]]];
    [postString appendString:[NSString stringWithFormat:@"&object_attribute_three=%@", [attributesArray objectAtIndex:2]]];
 */
    
    [URLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"postString: %@", postString);
    
    CreateProductAPIHandler *productAPIHandler = [[CreateProductAPIHandler alloc] init];
    productAPIHandler.delegate = delegate;
    productAPIHandler.theWebRequest = [SMWebRequest requestWithURLRequest:URLRequest delegate:productAPIHandler context:NULL];
    [productAPIHandler.theWebRequest addTarget:productAPIHandler action:@selector(productCreateRequestFinished:) forRequestEvents:SMWebRequestEventComplete];
    [productAPIHandler.theWebRequest start];
    
}


-(void)productCreateRequestFinished:(id)obj
{
    NSString* newStr = [[[NSString alloc] initWithData:responseData
                                              encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"newStr: %@", newStr);
}

@end
