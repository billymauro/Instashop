//
//  PurchasingAddressViewController.h
//  Instashop
//
//  Created by Josh Klobe on 7/8/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchasingAddressViewController : UIViewController
{
    id doneButtonDelegate;    
    id shippingCompleteDelegate;
    
    
    UIImageView *productImageView;
    UILabel *productTitleLabel;
    UILabel *sizeValueLabel;
    UILabel *sizeTextLabel;
    UILabel *quantityValueLabel;
    UILabel *quantityTextLabel;
    UILabel *priceValueLabel;
    UILabel *priceTextLabel;
    
    UITextField *nameTextField;
    UITextField *addressTextField;
    UITextField *cityTextField;
    UITextField *stateTextField;
    UITextField *zipTextField;
    UITextField *phoneTextField;
    
    UIButton *checkRatesButton;
    UIButton *doneButton;
    
    NSDictionary *sellerDictionary;
        
    NSDictionary *upsRateDictionary;
    NSDictionary *fedexRateDictionary;
}


-(void)loadWithSizeSelection:(NSString *)sizeSelection withQuantitySelection:(NSString *)quantitySelection withProductImage:(UIImage *)productImage;
-(void)loadWithRequestedProductObject:(NSDictionary *)theProductObject;

-(IBAction)checkRatesButtonHit;
-(IBAction)doneButtonHit;


@property (nonatomic, retain) id doneButtonDelegate;
@property (nonatomic, retain) id shippingCompleteDelegate;

@property (nonatomic, retain) IBOutlet UIImageView *productImageView;
@property (nonatomic, retain) IBOutlet UILabel *productTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *sizeValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *sizeTextLabel;
@property (nonatomic, retain) IBOutlet UILabel *quantityValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *quantityTextLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceTextLabel;


@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextField *addressTextField;
@property (nonatomic, retain) IBOutlet UITextField *cityTextField;
@property (nonatomic, retain) IBOutlet UITextField *stateTextField;
@property (nonatomic, retain) IBOutlet UITextField *zipTextField;
@property (nonatomic, retain) IBOutlet UITextField *phoneTextField;

@property (nonatomic, retain) IBOutlet UIButton *checkRatesButton;
@property (nonatomic, retain) IBOutlet UIButton *doneButton;

@property (nonatomic, retain) NSDictionary *sellerDictionary;

@property (nonatomic, retain) NSDictionary *upsRateDictionary;
@property (nonatomic, retain) NSDictionary *fedexRateDictionary;

@end


