//
//  EditViewController.m
//  私人通讯录
//
//  Created by 张恒 on 15/10/14.
//  Copyright © 2015年 zhangheng. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton *btn;



- (IBAction)editBtnOnClick:(UIBarButtonItem *)sender;


@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.text = self.contact.name;
    self.numberField.text = self.contact.phoneNumber;
    
   
}

- (IBAction)saveBtnOnClick:(id)sender {
   
    //移除栈顶控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    //修改模型数据
    _contact.name = _nameField.text;
    _contact.phoneNumber = _numberField.text;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(editViewControllerDidClickSaveBtn:andContact:)]) {
        [self.delegate editViewControllerDidClickSaveBtn:self andContact:self.contact];
    }
}
 
- (IBAction)editBtnOnClick:(UIBarButtonItem *)sender {
    if (self.nameField.enabled == NO) {
        self.btn.hidden = NO;
        self.nameField.enabled = YES;
        self.numberField.enabled = YES;
        [self.numberField becomeFirstResponder];
        sender.title = @"取消";
    }else{
        self.btn.hidden = YES;
        self.nameField.enabled = NO;
        self.numberField.enabled = NO;
        [self.view endEditing:YES];
        _nameField.text = _contact.name;
        _numberField.text = _contact.phoneNumber;
        
        sender.title = @"编辑";
    }
}
@end
