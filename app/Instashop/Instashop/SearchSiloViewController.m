//
//  SearchSiloViewController.m
//  Instashop
//
//  Created by Josh Klobe on 9/11/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "SearchSiloViewController.h"
#import "CategoriesTableViewController.h"
#import "AttributesManager.h"
#import "CategoriesViewController.h"
#import "ProductSelectTableViewController.h"
#import "SellerSelectTableViewController.h"
#import "SearchButtonContainerView.h"
@interface SearchSiloViewController ()

@end

@implementation SearchSiloViewController


@synthesize parentController;
@synthesize theSearchBar;
@synthesize contentContainerView;
@synthesize categoriesNavigationController;
@synthesize selectedCategoriesArray;
@synthesize searchTermsImageView;
@synthesize freeSearchTextArray;
@synthesize searchPromptLabel;
@synthesize separatorImageView;
@synthesize searchType;
@synthesize objectSelectTableViewController;
@synthesize searchButtonsArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.searchButtonsArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.selectedCategoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.freeSearchTextArray = [[NSMutableArray alloc] initWithCapacity:0];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Menu_BG"]];
    
    self.contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.separatorImageView.frame.origin.y + self.separatorImageView.frame.size.height,320, self.view.frame.size.height - (self.separatorImageView.frame.origin.x + self.separatorImageView.frame.size.height))];
    self.contentContainerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentContainerView];
    
    CategoriesTableViewController *productCategoriesTableViewController = [[CategoriesTableViewController alloc] initWithNibName:nil bundle:nil];
    productCategoriesTableViewController.categoriesType = self.searchType;
    productCategoriesTableViewController.view.backgroundColor = [UIColor clearColor];
    productCategoriesTableViewController.tableView.backgroundColor = [UIColor clearColor];
    productCategoriesTableViewController.positionIndex = 0;
    productCategoriesTableViewController.parentController = self;
    if (self.searchType == CATEGORIES_TYPE_SELLER)
        productCategoriesTableViewController.categoriesArray = [[AttributesManager getSharedAttributesManager] getShopsCategories];
    else
        productCategoriesTableViewController.categoriesArray = [[AttributesManager getSharedAttributesManager] getCategoriesWithArray:[NSArray array]];
    
    
    self.categoriesNavigationController = [[UINavigationController alloc] initWithRootViewController:productCategoriesTableViewController];
    [self.categoriesNavigationController setNavigationBarHidden:YES];
    [self.contentContainerView addSubview:categoriesNavigationController.view];
    
    
    if (self.searchType == CATEGORIES_TYPE_SELLER)
    {
        self.objectSelectTableViewController = [[SellerSelectTableViewController alloc] initWithNibName:@"SellerSelectTableViewController" bundle:nil];
        self.objectSelectTableViewController.rowSelectedDelegate = self.parentController;
        self.objectSelectTableViewController.view.frame = CGRectMake(0, 0, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
        self.objectSelectTableViewController.tableView.frame = CGRectMake(0, 0, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
        self.objectSelectTableViewController.tableView.backgroundColor = [UIColor whiteColor];
        
    }
    else
    {
        self.objectSelectTableViewController = [[ProductSelectTableViewController alloc] initWithNibName:@"ProductSelectTableViewController" bundle:nil];
        self.objectSelectTableViewController.cellDelegate = self.parentController;
        self.objectSelectTableViewController.productRequestorType = PRODUCT_REQUESTOR_TYPE_SEARCH;
        self.objectSelectTableViewController.view.frame = CGRectMake(0, 0, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
        self.objectSelectTableViewController.tableView.frame = CGRectMake(0, 0, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
        self.objectSelectTableViewController.tableView.backgroundColor = [UIColor whiteColor];
    }

    
}

-(void)runSearch
{
    if ([self.freeSearchTextArray count] > 0 || [self.selectedCategoriesArray count] > 0)
    {
        if ([self.objectSelectTableViewController.tableView superview] == nil)
        {
            self.searchPromptLabel.alpha = 0;
            [self.contentContainerView addSubview:self.objectSelectTableViewController.tableView];
        }
        
        self.objectSelectTableViewController.searchRequestObject = [[SearchRequestObject alloc] initWithCategoriesArray:self.selectedCategoriesArray withFreeTextArray:self.freeSearchTextArray];
        [self.objectSelectTableViewController refreshContent];
    }
}



-(void)categorySelected:(NSString *)theCategory withCallingController:(CategoriesTableViewController *)callingController
{
    if ([self.selectedCategoriesArray count] > callingController.positionIndex)
        [self.selectedCategoriesArray removeObjectsInRange:NSMakeRange(callingController.positionIndex, [self.selectedCategoriesArray count] - callingController.positionIndex)];
    
    
    if ([theCategory rangeOfString:@"All"].length > 0)
    {
        [self layoutSearchBarContainers];
        [self runSearch];
    }
    else
    {
        [self.selectedCategoriesArray addObject:theCategory];
        
        if ([[AttributesManager getSharedAttributesManager] getCategoriesWithArray:self.selectedCategoriesArray] == nil || self.searchType ==  CATEGORIES_TYPE_SELLER)
        {
            [self layoutSearchBarContainers];
            [self runSearch];
        }
        else
        {
            NSMutableArray *nextCategoriesArray = [NSMutableArray arrayWithCapacity:0];
            [nextCategoriesArray addObject:[NSString stringWithFormat:@"All %@", [self getCategoriesString]]];
            [nextCategoriesArray addObjectsFromArray:[[AttributesManager getSharedAttributesManager] getCategoriesWithArray:self.selectedCategoriesArray]];
        
        
            CategoriesTableViewController *categoriesTableViewController = [[CategoriesTableViewController alloc] initWithNibName:nil bundle:nil];
            categoriesTableViewController.categoriesType = self.searchType;
            categoriesTableViewController.view.backgroundColor = [UIColor clearColor];
            categoriesTableViewController.tableView.backgroundColor = [UIColor clearColor];
            categoriesTableViewController.basePriorCategoriesArray = [[NSArray alloc] initWithArray:self.selectedCategoriesArray];
            categoriesTableViewController.positionIndex = callingController.positionIndex + 1;
            categoriesTableViewController.parentController = self;
            categoriesTableViewController.categoriesArray = nextCategoriesArray;
        
        
            UIViewController *containerViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
            containerViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Menu_BG"]];
            [containerViewController.view addSubview:categoriesTableViewController.tableView];
        
            categoriesTableViewController.tableView.frame = CGRectMake(0,2, categoriesTableViewController.tableView.frame.size.width, categoriesTableViewController.tableView.frame.size.height);
            
            [self.categoriesNavigationController pushViewController:containerViewController animated:YES];
        }
    
    }
    
}




-(void)layoutSearchBarContainers
{
    float indentPoint = 10;
    
    if ([self.selectedCategoriesArray count] > 0)
    {
        BOOL proceed = YES;
        
        for (int i = 0; i < [self.searchButtonsArray count]; i++)
        {
            SearchButtonContainerView *theButtonContainer = [self.searchButtonsArray objectAtIndex:i];
            if (theButtonContainer.type == SEARCH_BUTTON_TYPE_CATEGORIES)
                proceed = NO;
        }
        
        if (proceed)
        {
            SearchButtonContainerView *buttonContainer = [[SearchButtonContainerView alloc] init];
            buttonContainer.type = SEARCH_BUTTON_TYPE_CATEGORIES;
            [self.searchButtonsArray addObject:buttonContainer];
            
            [buttonContainer loadWithSearchTerm:[self getCategoriesString] withClickDelegate:self];
        }
        
    }
    
    
    for (int i = 0; i < [self.freeSearchTextArray count]; i++)
    {
        BOOL proceed = YES;
        
        for (int j = 0; j < [self.searchButtonsArray count]; j++)
        {
            SearchButtonContainerView *theButtonContainer = [self.searchButtonsArray objectAtIndex:j];
            
            
            if ([theButtonContainer.searchTerm compare:[self.freeSearchTextArray objectAtIndex:i]] == NSOrderedSame)
                proceed = NO;
        }
        if (proceed)
        {
            SearchButtonContainerView *buttonContainer = [[SearchButtonContainerView alloc] init];
            buttonContainer.type = SEARCH_BUTTON_TYPE_FREE;
            [self.searchButtonsArray addObject:buttonContainer];
            
            [buttonContainer loadWithSearchTerm:[self.freeSearchTextArray objectAtIndex:i] withClickDelegate:self];
        }
        
    }
    
    for (int i = 0; i < [self.searchButtonsArray count]; i++)
    {
        SearchButtonContainerView *aView = [self.searchButtonsArray objectAtIndex:i];
        [aView removeFromSuperview];
    }
    
    for (int i = 0; i < [self.searchButtonsArray count]; i++)
    {
        SearchButtonContainerView *buttonContainerView = [self.searchButtonsArray objectAtIndex:i];
        buttonContainerView.frame = CGRectMake(indentPoint, self.searchTermsImageView.frame.origin.y + self.searchTermsImageView.frame.size.height / 8, [buttonContainerView.searchTerm sizeWithFont:buttonContainerView.searchLabel.font].width + 20, self.searchTermsImageView.frame.size.height - self.searchTermsImageView.frame.size.height / 4);
        
        indentPoint = buttonContainerView.frame.origin.x + buttonContainerView.frame.size.width + 15;
        [self.view addSubview:buttonContainerView];
        [buttonContainerView sizeViewWithFrame];
    }
    
    if ([self.searchButtonsArray count] == 0)
    {
        self.searchPromptLabel.alpha = 1;
        [self.objectSelectTableViewController.tableView removeFromSuperview];
    }
}


-(void)searchButtonContainerHit:(SearchButtonContainerView *)theButton
{

    switch (theButton.type) {
        case SEARCH_BUTTON_TYPE_CATEGORIES:
            [self.selectedCategoriesArray removeAllObjects];
            [self.categoriesNavigationController popToRootViewControllerAnimated:YES];
            break;
        
        case SEARCH_BUTTON_TYPE_FREE:
            [self.freeSearchTextArray removeObject:theButton.searchTerm];
        default:
            break;
    }
    
    [theButton removeFromSuperview];
    [self.searchButtonsArray removeObject:theButton];
    
    [self layoutSearchBarContainers];
    [self runSearch];
}


-(NSString *)getCategoriesString
{
    NSMutableString *titleString = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < [self.selectedCategoriesArray count]; i++)
    {
        [titleString appendString:[NSString stringWithFormat:@" %@", [self.selectedCategoriesArray objectAtIndex:i]]];
        if (i != [self.selectedCategoriesArray count] -1)
            [titleString appendString:@" >"];
        
    }
    
    return titleString;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.freeSearchTextArray addObject:searchBar.text];
    [self.theSearchBar resignFirstResponder];
    [self layoutSearchBarContainers];
    searchBar.text = @"";
    [self runSearch];
    
}





@end