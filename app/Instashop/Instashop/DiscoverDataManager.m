//
//  DiscoverDataManager.m
//  Instashop
//
//  Created by Josh Klobe on 11/22/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//


#import "DiscoverDataManager.h"
#import "AppDelegate.h"
#import "MediaLikedObject.h"
@implementation DiscoverDataManager

static DiscoverDataManager *theSharedMan;

@synthesize sellersObjectsArray;
@synthesize contentArray;
@synthesize unsortedDictionary;
@synthesize likedArray;
@synthesize referenceTableViewController;



+(DiscoverDataManager *)getSharedDiscoverDataManager
{
    if (theSharedMan == nil)
    {
        theSharedMan = [[DiscoverDataManager alloc] init];
        NSLog(@"getSharedDiscoverDataManager!");
        [ProductAPIHandler getAllProductsWithDelegate:theSharedMan];
    }
    
    return theSharedMan;
    
}

-(void)feedRequestFinishedWithArrray:(NSArray *)theArray
{
    NSLog(@"feedRequestFinishedWithArrray");
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.likedArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.unsortedDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.contentArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [theArray count]; i++)
    {
        NSDictionary *dict = [theArray objectAtIndex:i];
        [self.unsortedDictionary setObject:dict forKey:[dict objectForKey:@"products_instagram_id"]];
    }
    
    
    NSLog(@"theArray: %@", theArray);
    
    for (int i = 0; i < [theArray count]; i++)
    {
        NSDictionary *dict = [theArray objectAtIndex:i];
        NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"media/%@", [dict objectForKey:@"products_instagram_id"]], @"method", nil];
        [appDelegate.instagram requestWithParams:params delegate:self];
    }
}


- (void)request:(IGRequest *)request didLoad:(id)result
{
    NSDictionary *dataDict = [result objectForKey:@"data"];
    
    MediaLikedObject *likedObject = [[MediaLikedObject alloc] init];
    likedObject.mediaID = [dataDict objectForKey:@"id"];
    
    NSDictionary *likesDict = [dataDict objectForKey:@"likes"];
    likedObject.likedCount = [[likesDict objectForKey:@"count"] integerValue];
    
    [self.likedArray addObject:likedObject];
    
    if ([self.likedArray count] == [[self.unsortedDictionary allKeys] count] - 1)
        [self sortAndPresent];
    //    NSLog(@"likedObject.mediaID: %@", likedObject.mediaID);
    //    NSLog(@"likedCount: %d", likedObject.likedCount);
    //    NSLog(@"result: %@", result);
}



-(void)sortAndPresent
{
    self.contentArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"sortAndPresent");
    
    [self.likedArray sortUsingComparator:
     ^NSComparisonResult(id obj1, id obj2){
         
         MediaLikedObject *p1 = (MediaLikedObject*)obj1;
         MediaLikedObject *p2 = (MediaLikedObject*)obj2;
         if (p1.likedCount < p2.likedCount) {
             return (NSComparisonResult)NSOrderedDescending;
         }
         
         else if (p1.likedCount > p2.likedCount) {
             return (NSComparisonResult)NSOrderedAscending;
         }
         else return (NSComparisonResult)NSOrderedSame;
     }
     ];
    
    for (int i = 0; i < [likedArray count]; i++)
    {
        MediaLikedObject *obj = [likedArray objectAtIndex:i];
        [self.contentArray addObject:[self.unsortedDictionary objectForKey:obj.mediaID]];
    }
    
    NSLog(@"done!: %@", self.referenceTableViewController);
    if (self.referenceTableViewController != nil)
    {
        [self.referenceTableViewController.contentArray removeAllObjects];
        [self.referenceTableViewController.contentArray addObjectsFromArray:self.contentArray];
        [self.referenceTableViewController.tableView reloadData];
    }
}




@end
