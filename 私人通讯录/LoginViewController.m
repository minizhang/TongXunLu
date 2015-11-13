//
//  LoginViewController.m
//  私人通讯录
//
//  Created by 张恒 on 15/10/14.
//  Copyright © 2015年 zhangheng. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+NJ.h"

#define ACCOUNT @"account"
#define PASSWORD @"pwd"
#define REMPWD @"rem_pwd"
#define AUTOLOGIN @"auto_login"

@interface LoginViewController ()<UITextFieldDelegate>

//账号
@property (weak, nonatomic) IBOutlet UITextField *accountField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
//登陆按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


//记住密码操作
- (IBAction)remChange:(id)sender;
//自动登陆操作
- (IBAction)autoLoginChange:(id)sender;
//记住密码开关
@property (weak, nonatomic) IBOutlet UISwitch *remSwitch;
//自动登陆开关
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

- (IBAction)loginOnClick:(UIButton *)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    获取通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    //读取偏好设置信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accountField.text = [defaults objectForKey:ACCOUNT];
    self.remSwitch.on = [defaults boolForKey:REMPWD];
    if (self.remSwitch.isOn) {
        // 需要记住密码
        self.pwdField.text = [defaults objectForKey:PASSWORD];
    }
    //是否需要自动登录
    self.autoLoginSwitch.on = [defaults boolForKey:AUTOLOGIN];
    if(self.autoLoginSwitch.isOn){
        [self loginOnClick:nil];
    }
}


- (void)textChange{
    self.loginBtn.enabled = (self.accountField.text.length > 0 && self.pwdField.text.length > 0);
}


- (IBAction)remChange:(id)sender {
    if(self.remSwitch.isOn == NO){
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginChange:(id)sender {
    if (self.autoLoginSwitch.isOn ) {
        [self.remSwitch setOn:YES animated:YES];
    }
}

- (IBAction)loginOnClick:(UIButton *)sender {
    //判断密码账户是否匹配（zh/123）
    
    //
    [MBProgressHUD showMessage:@"正在加载"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.accountField.text isEqualToString: @"zh"] && [self.pwdField.text isEqualToString:@"123"]) {
            [self performSegueWithIdentifier:@"login2contact" sender:nil];
            [MBProgressHUD hideHUD];
            
            //保存偏好设置信息
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //1.账号
            [defaults setObject:self.accountField.text forKey:ACCOUNT];
            //2.密码
            [defaults setObject:self.pwdField.text forKey:PASSWORD];
            //3.是否自动登录
            [defaults setBool:self.autoLoginSwitch.isOn forKey:AUTOLOGIN];
            //4.是否记住密码
            [defaults setBool:self.remSwitch.isOn forKey:REMPWD];
            //立刻保存数据
            [defaults synchronize];
            
        }else{
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或者密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"账户名或密码错误！"];
        }
    });
    
    
    //
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController * vc = segue.destinationViewController;
    vc.title = [NSString stringWithFormat:@"%@的联系人列表",self.accountField.text];
}


@end
