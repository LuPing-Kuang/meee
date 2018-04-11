//
//  RegisterViewController.m
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserDataLoader.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *otherLoginWayView;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;

@property (nonatomic,strong) NSTimer *countDownTimer;
@property (nonatomic,assign) NSInteger count;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)closelogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)registerBtnClick:(id)sender {
    
    if (self.phoneTextField.text.length!=11) {
        [HUDManager showErrorMsg:@"请输入11位手机号码"];
        return;
    }
    
    if (self.codeTf.text.length!=6) {
        [HUDManager showErrorMsg:@"请输入6位验证码"];
        return;
    }
    
    if (self.passwordTextField.text.length==0) {
        [HUDManager showErrorMsg:@"请输入密码"];
        return;
    }
    [HUDManager showLoading:@"注册中..."];
    MJWeakSelf;
    [UserDataLoader registerWithMobile:self.phoneTextField.text WithPwd:self.passwordTextField.text WithVerifycode:self.codeTf.text withCompleted:^(id result, BOOL success) {
        if (success) {
            [HUDManager showSuccessMsg:@"注册成功"];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
    
    
    
}


- (IBAction)wechatLogin:(id)sender {
    
}
- (IBAction)getVerifyCode:(id)sender {
    
    if (self.phoneTextField.text.length!=11) {
        [HUDManager showErrorMsg:@"请输入11位手机号码"];
        return;
    }
    
    [HUDManager showLoading:@"发送中..."];
    MJWeakSelf;
    [UserDataLoader getCodeWithMobile:self.phoneTextField.text WithTemp:@"sms_reg" withCompleted:^(id result, BOOL success) {
        if (success) {
            [HUDManager showSuccessMsg:@"发送成功"];
            weakSelf.count = DefaultCountDownSecond;
            weakSelf.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendSMSSuccess) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.countDownTimer forMode:NSRunLoopCommonModes];
            [weakSelf.countDownTimer fire];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
    
}

#pragma mark -
#pragma mark - 发送短信
- (void)sendSMSSuccess{
    if (self.count == 0) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        [self.codeButton setEnabled:YES];
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
    }else{
        [self.codeButton setEnabled:NO];
        NSString *sting = [NSString stringWithFormat:@"%lu秒",(NSInteger)self.count];
        [self.codeButton setTitle:sting forState:UIControlStateNormal];
        [self.codeButton setTitleColor:RGB(184, 184, 184) forState:UIControlStateNormal];
    }
    self.count --;
    
}


- (void)dealloc{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}


@end
