//
//  AddViewController.m
//  私人通讯录
//
//  Created by 张恒 on 15/10/14.
//  Copyright © 2015年 zhangheng. All rights reserved.
//

#import "AddViewController.h"
#import "ZHContact.h"
@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    获取通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //    注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberField];
}


- (IBAction)addBtnOnClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    ZHContact * c = [[ZHContact alloc] init];
    NSString * name = self.nameField.text;
    NSString * number = self.numberField.text;
    c.name = name;
    c.phoneNumber = number;
    
    if ([self.delegate respondsToSelector:@selector(AddViewControllerDidAddBtn:andContact:)]) {
        [self.delegate AddViewControllerDidAddBtn:self andContact:c];
    }
    
}


- (void)textChange{
    self.addBtn.enabled = (self.nameField.text.length > 0 && self.numberField.text.length > 0);
}







@end
