//
//  LoginViewController.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "LoginViewController.h"
#import "WechatHandler.h"
#import "UserDataLoader.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *otherLoginWayView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)closelogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)forgetPassword:(id)sender {
    
}

- (IBAction)gologin:(id)sender {
    
    if (self.phoneTextField.text.length!=11) {
        [HUDManager showErrorMsg:@"请输入11位手机号码"];
        return;
    }
    
    if (self.passwordTextField.text.length==0) {
        [HUDManager showErrorMsg:@"请输入密码"];
        return;
    }
    
    [HUDManager showLoading:@"登录中..."];
    MJWeakSelf;
    [UserDataLoader loginWithMobile:self.phoneTextField.text WithPwd:self.passwordTextField.text withCompleted:^(id result, BOOL success) {
        if (success) {
            [UserModel saveToken:result[@"access_token"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:UserLogin_Notification object:nil];
            [HUDManager showSuccessMsg:@"登录成功"];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
    
}



- (IBAction)wechatLogin:(id)sender {
//    [[WechatHandler sharedInstance] wechatLogin];
}

@end
