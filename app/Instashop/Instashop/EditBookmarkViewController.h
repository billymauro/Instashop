//
//  EditBookmarkViewController.h
//  CIALBrowser
//
//  Created by Sylver Bruneau on 03/03/12.
//  Copyright 2012 CodeIsALie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkObject.h"

@interface EditBookmarkViewController : UITableViewController<UITextFieldDelegate, UIActionSheetDelegate> {
    id _delegate;
    BookmarkObject *_bookmark;
    UITextField *_nameTextField;
    UITextField *_urlTextField;
}

@property (strong,nonatomic) id delegate;
@property (strong,nonatomic) BookmarkObject *bookmark;

@end
