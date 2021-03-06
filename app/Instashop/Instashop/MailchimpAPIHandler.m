//
//  MailchimpAPIHandler.m
//  Instashop
//  Used to post a new user's data to Shopsy's storage for use with Shopsy server mailchimp handling
//  Created by Josh Klobe on 1/24/14.
//  Copyright (c) 2014 Josh Klobe. All rights reserved.
//

#import "MailchimpAPIHandler.h"
#import "InstagramUserObject.h"

@implementation MailchimpAPIHandler


+(void)makeMailchimpCallWithEmail:(NSString *)theEmail withCategory:(NSString *)category withName:(NSString *)theName;
{
    NSString *urlRequestString = [NSString stringWithFormat:@"%@/%@", [Utils getRootURI], @"shopsy_mailchimp_receiver.php"];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequestString]];
    URLRequest.HTTPMethod = @"POST";
    
    
    
    NSString *followers = [[InstagramUserObject getStoredUserObject].counts objectForKey:@"followed_by"];
    
    NSMutableString *postString = [NSMutableString stringWithCapacity:0];
    [postString appendString:[NSString stringWithFormat:@"action=%@", @"submit_email"]];
    [postString appendString:[NSString stringWithFormat:@"&email=%@&", theEmail]];
    [postString appendString:[NSString stringWithFormat:@"&instagram_username=%@", [InstagramUserObject getStoredUserObject].username]];
    [postString appendString:[NSString stringWithFormat:@"&category=%@", category]];
    [postString appendString:[NSString stringWithFormat:@"&followers=%@", followers]];
    [postString appendString:[NSString stringWithFormat:@"&name=%@", theName]];

    
    [URLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"search, urlRequestString: %@", urlRequestString);
    NSLog(@"post string: %@", postString);
    
    MailchimpAPIHandler *apiHandler = [[MailchimpAPIHandler alloc] init];
    apiHandler.theWebRequest = [SMWebRequest requestWithURLRequest:URLRequest delegate:apiHandler context:NULL];
    [apiHandler.theWebRequest addTarget:apiHandler action:@selector(makeMailchimpCallWithEmailDone:) forRequestEvents:SMWebRequestEventComplete];
    [apiHandler.theWebRequest start];

}

-(void)makeMailchimpCallWithEmailDone:(id)obj
{
//    NSLog(@"makeMailchimpCallWithEmailDone: %@", obj);
    
    NSString* newStr = [[NSString alloc] initWithData:responseData
                                             encoding:NSUTF8StringEncoding];
    
    NSLog(@"makeMailchimpCallWithEmailDone: %@", newStr);
    
}
@end
