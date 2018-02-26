//
//  BindMobileController.m
//  me
//
//  Created by KLP on 2018/2/26.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BindMobileController.h"
#import "UserDataLoader.h"
#import "MyPageHttpTool.h"
@interface BindMobileController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic,strong) NSTimer *countDownTimer;
@property (nonatomic,assign) NSInteger count;

@end

@implementation BindMobileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mobileTf.text = self.mobile;
    self.saveBtn.layer.cornerRadius = 5.0;
    self.saveBtn.layer.masksToBounds = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 4.0;
    }else{
        return 2.0;
    }
}

- (IBAction)bindBtnClick:(UIButton *)sender {
    
    if (self.mobileTf.text.length == 0) {
        [self showErrorMsg:@"请输入手机号"];
        return;
    }
    
    if (self.codeTf.text.length == 0) {
        [self showErrorMsg:@"请输入验证码"];
        return;
    }
    
    [HUDManager showLoading:@"发送中..."];
    MJWeakSelf;
    
    [MyPageHttpTool bindMyPhone:self.mobileTf.text verifycode:self.codeTf.text withCompleted:^(id result, BOOL success) {
        if (success) {
            [HUDManager showSuccessMsg:@"成功绑定"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
    
    
}

- (IBAction)codeBtnClick:(UIButton *)sender {
    
    if (self.mobileTf.text.length==0) {
        [HUDManager showErrorMsg:@"请输入手机号"];
        return;
    }
    
    [HUDManager showLoading:@"发送中..."];
    MJWeakSelf;
    [UserDataLoader getCodeWithMobile:self.mobileTf.text WithTemp:@"sms_bind" withCompleted:^(id result, BOOL success) {
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
