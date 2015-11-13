//
//  AddViewController.h
//  私人通讯录
//
//  Created by 张恒 on 15/10/14.
//  Copyright © 2015年 zhangheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHContact;
@class AddViewController;
@protocol AddViewDelegate <NSObject>

- (void)AddViewControllerDidAddBtn:(AddViewController *)addViewController andContact:(ZHContact *)contact;

@end

@interface AddViewController : UIViewController

@property (nonatomic, weak)id<AddViewDelegate> delegate;

@end
