//
//  ISRowContainerView.m
//  Instashop
//
//  Created by Josh Klobe on 8/21/13.
//  Copyright (c) 2013 Josh Klobe. All rights reserved.
//

#import "ISRowContainerView.h"

@implementation ISRowContainerView

@synthesize backgroundImageView;
@synthesize separatorImageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}



@end
