//
//  SellersTableViewCell.m
//  Instashop
//  Table Cell to present a seller in the Search -> Shops view
//  Created by Josh Klobe on 9/12/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "SellersTableViewCell.h"
#import "IGRequest.h"
#import "AppDelegate.h"
#import "ImageAPIHandler.h"

@implementation SellersTableViewCell

@synthesize sellerImageView;
@synthesize sellerTextLabel;
@synthesize urlString;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) loadWithDictionary:(NSDictionary *)theDictionary
{
    float sizeValue = self.frame.size.height - self.frame.size.height * .2;
    if (self.sellerImageView == nil)
    {
        self.sellerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.frame.size.height * .1, sizeValue, sizeValue)];
        [self addSubview:self.sellerImageView];
    }
    
    if (self.sellerTextLabel == nil)
    {
        self.sellerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sellerImageView.frame.origin.x + self.sellerImageView.frame.size.width + 20, self.sellerImageView.frame.origin.y, 200, self.sellerImageView.frame.size.height)];
        self.sellerTextLabel.backgroundColor = [UIColor clearColor];
        self.sellerTextLabel.textAlignment = NSTextAlignmentLeft;
        self.sellerTextLabel.textColor = [UIColor blackColor];
        [self addSubview:self.sellerTextLabel];
    }
    
    self.sellerTextLabel.text = @"";
    self.sellerImageView.image = nil;
    
    NSDictionary *dataDictionary = [theDictionary objectForKey:@"data"];
    self.sellerTextLabel.text = [dataDictionary objectForKey:@"username"];
    self.urlString = [dataDictionary objectForKey:@"profile_picture"];
    [ImageAPIHandler makeImageRequestWithDelegate:self withInstagramMediaURLString:self.urlString withImageView:self.sellerImageView];
}


-(void)imageReturnedWithURL:(NSString *)url withImage:(UIImage *)theImage
{
    if ([url compare:self.urlString] == NSOrderedSame)
        self.sellerImageView.image = theImage;
}




@end
