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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 4.0;
    }else{
        return 2.0;
    }
}


- (IBAction)textFieldDidChange:(UITextField *)sender {
    
    NSInteger kMaxLength = kMaxPhoneLength;
    if (sender == self.mobileTf) {
        kMaxLength = kMaxPhoneLength;
    }else {
        kMaxLength = kMaxCodeLength;
    }
    
    
    NSString *toBeString = sender.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [sender markedTextRange];
        //获取高亮部分
        UITextPosition *position = [sender positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                sender.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            sender.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    
    
}



- (IBAction)bindBtnClick:(UIButton *)sender {
    
    if (self.mobileTf.text.length != 11) {
        [self showErrorMsg:@"请输入11位手机号"];
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
    
    if (self.mobileTf.text.length != 11) {
        [self showErrorMsg:@"请输入11位手机号"];
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
