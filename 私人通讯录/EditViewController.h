//
//  EditViewController.h
//  私人通讯录
//
//  Created by 张恒 on 15/10/14.
//  Copyright © 2015年 zhangheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHContact.h"

@class EditViewController;
@protocol EditViewControllerDelegate <NSObject>

- (void) editViewControllerDidClickSaveBtn:(EditViewController *) editViewController andContact:(ZHContact *)contact;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) ZHContact * contact;

@property (nonatomic, weak) id<EditViewControllerDelegate> delegate;

@end
